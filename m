Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FBCCD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXXz3-0007jw-4y; Thu, 11 Jun 2026 01:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXyq-0007g8-2N
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXyn-0000pE-O6
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:27 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GJDG2247953
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rv213hShBFG7pzB8K8avEUxDRUaR+YO/+vurJzYVszc=; b=Gf/tgS2ildyjW6Qk
 NS6uCehY0/hVYQeujsTLfCg/+p+RamTmEUqnWmkLSRX0FL6OJSiTZl/44mwbbbo+
 BHTG59ymbG8Nxdsrag+BTzZeqlK88tqNNuBc67zustZn7FgZ2kVhil7tqsumWWEN
 ucAT/sbQkWG1prl2kxUoUX6lDG7vLf1yW+bpcHVHrInOppxbhVL3gkXd1PaPDe/n
 uW2VRJfAAsJOUrZypymqDdf79p+42ilWNJKON447Asfg5M4kh4V9t/dINli4WJq1
 OmVzafgYyKpVytLVRaBs97rotxIVQQ3zPYAz0unb3SxquyXrBLhAOuJlHJ73nEmg
 62x6iQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe79hr4n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:22 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304d0d0b28eso10718906eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155762; x=1781760562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rv213hShBFG7pzB8K8avEUxDRUaR+YO/+vurJzYVszc=;
 b=HTDL5QD01EsN0zGew+ho0w8yeBP5gDKOSoVoVV0F8OoHT8PRHq+aFLbH47WS6d7jo1
 H8T7FPzjGahQrJNgA9okic1zwUr/HRUvsMrQ7WIiwjqdqEvHsRAk8Ga8KTlEKQYZFZvM
 uk7/HgpgalKvMD/Jx7hflyi8EG+0HGYYpkMcjrHP6NOn9KDaiPHMpeTubnAzjt5KXS/8
 7+364CmMSrRPM+Dap/q8fhWTcptvDcYpXgVoXEJg0l3VEwvvybm+r13Y383BWynLzqKO
 7nu2xCyOScn5S5Es/bu+qFLWIQgviqID3G2eTeH2100sr0q+eFIF9RKUOBeEfxRjw/54
 rCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155762; x=1781760562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rv213hShBFG7pzB8K8avEUxDRUaR+YO/+vurJzYVszc=;
 b=rL4eJBVPQOMU3/SExGDmI3U4lGAPDCqc7tGic2xweAyOEgM/9hxVSLgjxZFhpn51Cr
 N2hM+oNjKd19ObN53Cnsz/1Q/muyzFXjCviLClXfqmXvM7f8SBSP0fgWC1IXF0nYmPXa
 sb3rg6Yz9pHv1wpEvvQdEoLCq9OX3SVOLFgyVG6tHyydIa37JC8qh2HkertW7Rv2Vi9c
 Qv0Fl5LvYBb9j0v8BJ1QRiXKX5M1dkj4FOwBSjHC13xxc5Vmn4PcjrF6sOSubrnoOTYp
 KKme0Rm7QL6gPKidb8XaqVtAy+l0XeCLw/5BkJ3KapINS9nRwbW7oiagIa4OwLV+Hpn0
 3BMA==
X-Gm-Message-State: AOJu0YzMiRwEmxoQ7xNkA0uatxdkHTwhoLlh+yz8ZQCZoKjNA4xuqlod
 cLHtJP1fWBW7PLL3i/Dy0fUVX5QeVgXJkTcoCxAdmI6riEiiSQu/vtZnHaE07JPA0JaxSANEPbd
 03AAVG7To89IBo11qrMHQ5xYDpNGhpb2klx2urZW2Ak4oJH0YUnvyJaCO2Ln4VYSq2A==
X-Gm-Gg: Acq92OFeXNsDX2mR4RwYLJuzAWchJu4vdd9SAnn/IukEaW24NM9LVehRqT4f8OWkWgS
 nh7+iwjv/PKkMkpGzT4FrRUxnvGtedp6GKouZx71wd5DZiiz0ZAC8wxc6Qq0bq+/fVk8MyqEt/Z
 FSzEPnMjGscl3AMTu6QYncq1AEOpIH4NEX35BFlD0XyYa/ycEMytlLcYRtVv0HlI00R/HKmaKCj
 rEgX+Fh9FhYML6oXwF4Gs/t8RBl1dIFKK8/Oi0tl7SwVUAge5AN6Dpm5vNXlQbkCQ7o2jpWBjkl
 JG2P5rJEE8io7upUAfxMM3mqYIHGWv+Pp//f9W5TngMz1+CvBOO4EB9nQYgxPX+Ntw/lVyJZOk2
 AeCbZiJbZBReoWsTcRUGQ3rrNuTpGHdpbjtqXrhdAEAVYXeqtxa65dbWoVDDx2F0V8AWlm+0lVa
 FZHaKI
X-Received: by 2002:a05:693c:3015:b0:304:9b48:53d0 with SMTP id
 5a478bee46e88-30804768d68mr1192900eec.12.1781155762061; 
 Wed, 10 Jun 2026 22:29:22 -0700 (PDT)
X-Received: by 2002:a05:693c:3015:b0:304:9b48:53d0 with SMTP id
 5a478bee46e88-30804768d68mr1192874eec.12.1781155761452; 
 Wed, 10 Jun 2026 22:29:21 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a402sm880475eec.17.2026.06.10.22.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:29:20 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v8] target/hexagon: Add guest, system reg number defs
Date: Wed, 10 Jun 2026 22:28:31 -0700
Message-Id: <20260611052857.3911981-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: T8UCa519MqasY5d4RQu43bs1tXCdLEga
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX2EeXY3Z3LVmC
 26cmHQsqeWpKq7IwW7w3je3FpwvKcIy5kXJXhxWH3+FgSq5cm2E7aFJT+7HK0sGAEVFJZLlPMci
 OR75tATtp/9f+K+/UM8MFzfB+4qf0L26D4Diat0J+bS/KekV3xDOeKLaHV3kxMl48topRywHKj/
 FwPH0NbcIFZtw2q8QyjQWVKkIc77kLATW63dOGnTa/r9WztpL8Cyg0gu9JhKDkGmv6U97uzPDpR
 zQktXLsGB8P6C7kYXr7IDbmdh8+8S/2yKb8gbGLthd5wvxf+Fm5IV26LI9aW1JpQnlSs6cFhy03
 JU7hca7zYYCQFKfrTGk3fDZPqun6jjpoW357fi4FqeJiSlJEkCwodzqWQv7nGO+bqjOmViD6ULa
 2SqmO8KT3ha7WAxhhyte/kaR7baAlG3KQj5Y0yTC6WHbvnWmqLF/lYZwqafEbSeLLkRCocUiEt5
 HZ8imsS2XPp+508IMAQ==
X-Proofpoint-GUID: T8UCa519MqasY5d4RQu43bs1tXCdLEga
X-Authority-Analysis: v=2.4 cv=fbydDUQF c=1 sm=1 tr=0 ts=6a2a47b2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=tCkOjFGBvLAhDY2OQcYA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfXxbZf8U0b/fvY
 xJfpahSUygUNOqCuZbyWVx6+DZWc/k+tPSdfdwdOEh2A//2In1YnuXF+l3Uckh2g+T+psjUiL/g
 qnEVj0sCjrCWxs0lFiEGI/+ELBTEYJk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110051
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9j
cHUuaCAgICAgIHwgICA3ICsrKwogdGFyZ2V0L2hleGFnb24vaGV4X3JlZ3MuaCB8IDExNyArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMjQg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0
L2hleGFnb24vY3B1LmgKaW5kZXggZTIyNTY3ZDhlNjcuLmUwY2Y4N2U1YTRjIDEwMDY0NAotLS0g
YS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtMjAs
NiArMjAsMTMgQEAKIAogI2luY2x1ZGUgImZwdS9zb2Z0ZmxvYXQtdHlwZXMuaCIKIAorI2lmbmRl
ZiBDT05GSUdfVVNFUl9PTkxZCisjZGVmaW5lIE5VTV9HUkVHUyAzMgorI2RlZmluZSBHUkVHX1dS
SVRFU19NQVggMgorI2RlZmluZSBOVU1fU1JFR1MgNjQKKyNkZWZpbmUgU1JFR19XUklURVNfTUFY
IDIKKyNlbmRpZgorCiAjaW5jbHVkZSAiY3B1LXFvbS5oIgogI2luY2x1ZGUgImV4ZWMvY3B1LWNv
bW1vbi5oIgogI2luY2x1ZGUgImV4ZWMvdGFyZ2V0X2xvbmcuaCIKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL2hleF9yZWdzLmggYi90YXJnZXQvaGV4YWdvbi9oZXhfcmVncy5oCmluZGV4IGJk
ZGZjMjgwMjFjLi4yMTRiN2I4ZmRlOCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGV4X3Jl
Z3MuaAorKysgYi90YXJnZXQvaGV4YWdvbi9oZXhfcmVncy5oCkBAIC04MSw0ICs4MSwxMjEgQEAg
ZW51bSB7CiAgICAgSEVYX1JFR19VVElNRVJISSAgICAgICAgICA9IDYzLAogfTsKIAorI2lmbmRl
ZiBDT05GSUdfVVNFUl9PTkxZCisKKyNkZWZpbmUgSEVYX0dSRUdfVkFMVUVTIFwKKyAgREVDTF9I
RVhfR1JFRyhHMCwgICAgICAgICAwKSBcCisgIERFQ0xfSEVYX0dSRUcoR0VMUiwgICAgICAgMCkg
XAorICBERUNMX0hFWF9HUkVHKEcxLCAgICAgICAgIDEpIFwKKyAgREVDTF9IRVhfR1JFRyhHU1Is
ICAgICAgICAxKSBcCisgIERFQ0xfSEVYX0dSRUcoRzIsICAgICAgICAgMikgXAorICBERUNMX0hF
WF9HUkVHKEdPU1AsICAgICAgIDIpIFwKKyAgREVDTF9IRVhfR1JFRyhHMywgICAgICAgICAzKSBc
CisgIERFQ0xfSEVYX0dSRUcoR0JBRFZBLCAgICAgMykgXAorICBERUNMX0hFWF9HUkVHKEdDWUNM
RV8xVCwgIDEwKSBcCisgIERFQ0xfSEVYX0dSRUcoR0NZQ0xFXzJULCAgMTEpIFwKKyAgREVDTF9I
RVhfR1JFRyhHQ1lDTEVfM1QsICAxMikgXAorICBERUNMX0hFWF9HUkVHKEdDWUNMRV80VCwgIDEz
KSBcCisgIERFQ0xfSEVYX0dSRUcoR0NZQ0xFXzVULCAgMTQpIFwKKyAgREVDTF9IRVhfR1JFRyhH
Q1lDTEVfNlQsICAxNSkgXAorICBERUNMX0hFWF9HUkVHKEdQTVVDTlQ0LCAgIDE2KSBcCisgIERF
Q0xfSEVYX0dSRUcoR1BNVUNOVDUsICAgMTcpIFwKKyAgREVDTF9IRVhfR1JFRyhHUE1VQ05UNiwg
ICAxOCkgXAorICBERUNMX0hFWF9HUkVHKEdQTVVDTlQ3LCAgIDE5KSBcCisgIERFQ0xfSEVYX0dS
RUcoR1BDWUNMRUxPLCAgMjQpIFwKKyAgREVDTF9IRVhfR1JFRyhHUENZQ0xFSEksICAyNSkgXAor
ICBERUNMX0hFWF9HUkVHKEdQTVVDTlQwLCAgIDI2KSBcCisgIERFQ0xfSEVYX0dSRUcoR1BNVUNO
VDEsICAgMjcpIFwKKyAgREVDTF9IRVhfR1JFRyhHUE1VQ05UMiwgICAyOCkgXAorICBERUNMX0hF
WF9HUkVHKEdQTVVDTlQzLCAgIDI5KSBcCisgIERFQ0xfSEVYX0dSRUdfRE9ORQorCisjZGVmaW5l
IERFQ0xfSEVYX0dSRUdfRE9ORQorI2RlZmluZSBERUNMX0hFWF9HUkVHKG5hbWUsIHZhbCkgSEVY
X0dSRUdfICMjbmFtZSA9IHZhbCwKK2VudW0gaGV4X2dyZWcgeworICAgIEhFWF9HUkVHX1ZBTFVF
UworfTsKKyN1bmRlZiBERUNMX0hFWF9HUkVHCisjdW5kZWYgREVDTF9IRVhfR1JFR19ET05FCisK
KyNkZWZpbmUgREVDTF9IRVhfR1JFR19ET05FIDAKKyNkZWZpbmUgREVDTF9IRVhfR1JFRyhfLCB2
YWwpICgxIDw8IHZhbCkgfAorc3RhdGljIGlubGluZSBib29sIGdyZWdfaW1wbGVtZW50ZWQoZW51
bSBoZXhfZ3JlZyBncmVnKQoreworI2lmIE5VTV9HUkVHUyA+IDMyCisjZXJyb3IgIk5VTV9HUkVH
UyB0b28gbGFyZ2UgZm9yIGdyZWdfaW1wbGVtZW50ZWQoKTogdXBkYXRlIGBpbXBsX2JpdG1hcGAi
CisjZW5kaWYKKyAgICBzdGF0aWMgaW50MzJfdCBpbXBsX2JpdG1hcCA9IEhFWF9HUkVHX1ZBTFVF
UzsKKyAgICByZXR1cm4gaW1wbF9iaXRtYXAgJiAoMSA8PCBncmVnKTsKK30KKyN1bmRlZiBERUNM
X0hFWF9HUkVHCisjdW5kZWYgREVDTF9IRVhfR1JFR19ET05FCisKKyNlbmRpZiAvKiBDT05GSUdf
VVNFUl9PTkxZICovCisKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorZW51bSB7CisgICAgSEVY
X1NSRUdfU0dQMCA9IDAsCisgICAgSEVYX1NSRUdfU0dQMSA9IDEsCisgICAgSEVYX1NSRUdfU1RJ
RCA9IDIsCisgICAgSEVYX1NSRUdfRUxSID0gMywKKyAgICBIRVhfU1JFR19CQURWQTAgPSA0LAor
ICAgIEhFWF9TUkVHX0JBRFZBMSA9IDUsCisgICAgSEVYX1NSRUdfU1NSID0gNiwKKyAgICBIRVhf
U1JFR19DQ1IgPSA3LAorICAgIEhFWF9TUkVHX0hUSUQgPSA4LAorICAgIEhFWF9TUkVHX0JBRFZB
ID0gOSwKKyAgICBIRVhfU1JFR19JTUFTSyA9IDEwLAorICAgIEhFWF9TUkVHX0dFVkIgID0gMTEs
CisgICAgSEVYX1NSRUdfR0xCX1NUQVJUID0gMTYsCisgICAgSEVYX1NSRUdfRVZCID0gMTYsCisg
ICAgSEVYX1NSRUdfTU9ERUNUTCA9IDE3LAorICAgIEhFWF9TUkVHX1NZU0NGRyA9IDE4LAorICAg
IEhFWF9TUkVHX0lQRU5EQUQgPSAyMCwKKyAgICBIRVhfU1JFR19WSUQgPSAyMSwKKyAgICBIRVhf
U1JFR19WSUQxID0gMjIsCisgICAgSEVYX1NSRUdfQkVTVFdBSVQgPSAyMywKKyAgICBIRVhfU1JF
R19JRUwgPSAyNCwKKyAgICBIRVhfU1JFR19TQ0hFRENGRyA9IDI1LAorICAgIEhFWF9TUkVHX0lB
SEwgPSAyNiwKKyAgICBIRVhfU1JFR19DRkdCQVNFID0gMjcsCisgICAgSEVYX1NSRUdfRElBRyA9
IDI4LAorICAgIEhFWF9TUkVHX1JFViA9IDI5LAorICAgIEhFWF9TUkVHX1BDWUNMRUxPID0gMzAs
CisgICAgSEVYX1NSRUdfUENZQ0xFSEkgPSAzMSwKKyAgICBIRVhfU1JFR19JU0RCU1QgPSAzMiwK
KyAgICBIRVhfU1JFR19JU0RCQ0ZHMCA9IDMzLAorICAgIEhFWF9TUkVHX0lTREJDRkcxID0gMzQs
CisgICAgSEVYX1NSRUdfTElWRUxPQ0sgPSAzNSwKKyAgICBIRVhfU1JFR19CUktQVFBDMCA9IDM2
LAorICAgIEhFWF9TUkVHX0JSS1BUQ0ZHMCA9IDM3LAorICAgIEhFWF9TUkVHX0JSS1BUUEMxID0g
MzgsCisgICAgSEVYX1NSRUdfQlJLUFRDRkcxID0gMzksCisgICAgSEVYX1NSRUdfSVNEQk1CWElO
ID0gNDAsCisgICAgSEVYX1NSRUdfSVNEQk1CWE9VVCA9IDQxLAorICAgIEhFWF9TUkVHX0lTREJF
TiA9IDQyLAorICAgIEhFWF9TUkVHX0lTREJHUFIgPSA0MywKKyAgICBIRVhfU1JFR19QTVVDTlQ0
ID0gNDQsCisgICAgSEVYX1NSRUdfUE1VQ05UNSA9IDQ1LAorICAgIEhFWF9TUkVHX1BNVUNOVDYg
PSA0NiwKKyAgICBIRVhfU1JFR19QTVVDTlQ3ID0gNDcsCisgICAgSEVYX1NSRUdfUE1VQ05UMCA9
IDQ4LAorICAgIEhFWF9TUkVHX1BNVUNOVDEgPSA0OSwKKyAgICBIRVhfU1JFR19QTVVDTlQyID0g
NTAsCisgICAgSEVYX1NSRUdfUE1VQ05UMyA9IDUxLAorICAgIEhFWF9TUkVHX1BNVUVWVENGRyA9
IDUyLAorICAgIEhFWF9TUkVHX1BNVVNUSUQwID0gNTMsCisgICAgSEVYX1NSRUdfUE1VRVZUQ0ZH
MSA9IDU0LAorICAgIEhFWF9TUkVHX1BNVVNUSUQxID0gNTUsCisgICAgSEVYX1NSRUdfVElNRVJM
TyA9IDU2LAorICAgIEhFWF9TUkVHX1RJTUVSSEkgPSA1NywKKyAgICBIRVhfU1JFR19QTVVDRkcg
PSA1OCwKKyAgICBIRVhfU1JFR19TNTkgPSA1OSwKKyAgICBIRVhfU1JFR19TNjAgPSA2MCwKKyAg
ICBIRVhfU1JFR19TNjEgPSA2MSwKKyAgICBIRVhfU1JFR19TNjIgPSA2MiwKKyAgICBIRVhfU1JF
R19TNjMgPSA2MywKK307CisjZW5kaWYgLyogIUNPTkZJR19VU0VSX09OTFkgKi8KKwogI2VuZGlm
Ci0tIAoyLjM0LjEKCg==

