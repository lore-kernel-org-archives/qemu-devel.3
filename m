Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AB0CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waiBo-00022n-Ro; Fri, 19 Jun 2026 18:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBn-00022E-K8
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waiBl-0001bo-UD
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 18:59:55 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLXpPK1368898
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=qFYqNPPFISG4W33OXfV6Z2hBY6Ip8YqwFk+1NFRkGKE=; b=Wd
 O8fR/M43CWr07gc8b8LX/ptcjEloJYx0f/EeaNLhXel2MwsjtlghLhO4VcFf/AOB
 rxsW07Y4pJYgqSIDq3rc3D+WWI3pvCu9uE0R9O9RYT1K8Qf3mmkcozpPLlbJKbs9
 bMIG9kJvm4orjIWeXUdgI0KXzSIDJU7McH2xVCkeWfwfVhJq6k2BmFzMyQu9oU5a
 HzUxuQMu1K0oT8ThM8iIC8NtrvH4lsoyumK9+ETbyd7+Bj2VHRrewlJUAIz2RsMO
 kNPKw/vnW5pWqQJOUY952Z7fKRSelWS230EEmI3DyQGaqIMUGIa8m39yorPrHAf8
 nNUJEy0M6rdzf1KyQAaQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewcy30brv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 22:59:42 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c03c1dda3so2095516eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 15:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781909982; x=1782514782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFYqNPPFISG4W33OXfV6Z2hBY6Ip8YqwFk+1NFRkGKE=;
 b=N/qoZFu2s3wzMTZwlpPd1uaEO1lS5K06v0gq6Os8i60ARsZYgnM8FwZwCNCgFaad1w
 cIsV2mQpC3F+TVfOEFFeKOj2Wi0i3Bxygh5fI1tPVylY+GNCGPWCv5XBuBS5w3xcbqVg
 mtNnLfIIuG0Q62+iyhhw5eXhGz9tB5lIeEtj5asD2uWXpPY08hDcFY7w4SuhKRvror7J
 UHbIy9/0x9Dbr1KntGUTnVYcyjMi+krdf4tdciaLy7t3FsG5MeWWywohpQ6LzaO85qFc
 kq5treWuv79NaZV1l/K3X25ooPdW7YMtn3+pXB40qu7JYDluA85LmszBkR6ALWoYkpC9
 AUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781909982; x=1782514782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qFYqNPPFISG4W33OXfV6Z2hBY6Ip8YqwFk+1NFRkGKE=;
 b=PMmt6RO425gqiqDfnkEqArrtiXFAD06Nay73Lu68/rqeYrzTP6FkVwsBZDNfm4hoV5
 EIVwMZ8SbEqV8ranJsk0EpHe6zB9OLrhop9WyTzHsFPzlxkU9A/lHTdkQ9Pcz2HBGO+l
 SlamCZ+3GOTLVAsTqsx9XLnCxa31JWo4by/yMLWy6h+VD9uQDDTEYRyZzMPfMgwN8oZL
 Km4zUdYePAggNEPIXL01HXd3sfS706BTV+6gvOymkjk6h34ztcKdjKcq9YVRfnXDe+Xn
 srBiVwASRMtYALoPz602DL7z7ULSR2MVLNpRuH3ZIt/JqiSFCiS9CynNVbykDIZ+Rmoi
 ZHQQ==
X-Gm-Message-State: AOJu0YzLLN4Se6MMyJCusLBG8g+yMKwdMujdS+RqbD/oasxCKmsTIJqx
 Mf0wAGZCc8nWmwGxPuGetxFQAwdv8PZY31YO4+7n+KBTOqTiK9i2mulygyQ4XOCYe+dpRdxtfv+
 6cDUPzLnMK6yu8oNMvq8fLqo1qqAbjUvJZ2BXNunOO10CCeEL5tstmRXVeBrOUrLxvg==
X-Gm-Gg: AfdE7ckxoSkQ4xYdRRYvlAb9rf4+I6Reg3sExyr1A+oDtr6rZFjT1fXyIZhkjU9GH75
 RXKEF3EruKt9byqinuXRWX5+zemVdmoV4ovx4/3INilNQKC1FaegH0Z5GWbFw2o62lJaT+8pax5
 IpcVLvg0dmJJc9vy72br8eBZF9OWcrKdiCdngytQ1xyAhLfoYBIc05Izy0gj5+23gK6PUQwa4rI
 lCAGyp5eT2UKlPK88i++UPqH9HxIrGrmcslATMrsConJTresef/IBp5Pz1XDIkp/pVo+9t5Z6R2
 /xQ8G73CfAEogcxOjyjTqE3Xr5DqJ3pQT2+wWz6Mf2TJNmyKn8hhOa/vVF87t3gy8Tth4ZNHlEg
 hqF9WeOXruHxB60jh5HKXPKowTxuvs3FcHVxYHtJlkq4WxN0+Yc5QKNOnZzI=
X-Received: by 2002:a05:7300:ac8a:b0:30b:f5c1:4484 with SMTP id
 5a478bee46e88-30c1dcc6923mr667975eec.35.1781909981977; 
 Fri, 19 Jun 2026 15:59:41 -0700 (PDT)
X-Received: by 2002:a05:7300:ac8a:b0:30b:f5c1:4484 with SMTP id
 5a478bee46e88-30c1dcc6923mr667953eec.35.1781909981535; 
 Fri, 19 Jun 2026 15:59:41 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1b4f7d81sm1309510eec.0.2026.06.19.15.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 15:59:40 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 18/74] target/hexagon: Add vmstate representation
Date: Fri, 19 Jun 2026 15:58:15 -0700
Message-Id: <20260619225911.159473-19-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: -TZEJykyoXlivK-mUX-nIA--4XXnsugr
X-Proofpoint-ORIG-GUID: -TZEJykyoXlivK-mUX-nIA--4XXnsugr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfX3GVJIgqSzLH9
 yUWEls4BddPxp3S7Y9/bv7De74KUfPAuI0i4YZvsQ53lpoJkNLYbKq2jUgnJjvVeAlUhglhpqKE
 48tuqqXZ1vnDxY1hEreY3Z3Xkzwtbu+3FU6EUvvOqST0AikOMu0huNT+AGD3WbUX7VNY+EwHfvu
 bYZB5+hdkKBjbq4DFE0EAXZIt1bKTYV5llPo1Uxp+zw+hh+KO6b95bDTlFgg26TVki9NA2d4MBR
 NGCqB+E6CfxDdszKHCqGHl2bD6iqx2/XunO3Fn+kUoxbqORKaGjKa2DU3FG8UfBkH/ivTM3MlI1
 joRx+Eoh0/4dCQ+UZPzNRcHj+lkctXDMuivQWq7y4OrqA9YkzFOWqgebA0OkdCsrVCOHWIFViQ6
 7AiWljSIhqE5bqHhSIfSFqDekL3U4ysS5ObHwEECKqG3t04ScWX6eXAAVsvKG9jVgJ56TXAuuzi
 MY5xlz46ejaLHra1G1g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMSBTYWx0ZWRfXyb+XDPB5aOEJ
 4biFy8O1Kkq8OHqPD5PRzdgJX0xdrrl91T5T7ZwwlIxrLIC5h4N/yrIU/PiP29FdQGqzOZ8OIBx
 seQmWnod+enQJbmdVa1mYS5XCiZa3Oo=
X-Authority-Analysis: v=2.4 cv=ZOvnX37b c=1 sm=1 tr=0 ts=6a35c9de cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=pDBHowQsxXgegazyqkAA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190221
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IFJpY2hhcmQg
SGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPgpTaWduZWQtb2ZmLWJ5OiBC
cmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFn
b24vaW50ZXJuYWwuaCB8ICA0ICsrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgfCAgMyAr
KysKIHRhcmdldC9oZXhhZ29uL21hY2hpbmUuYyAgfCAzMiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKwogMyBmaWxlcyBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgdGFyZ2V0L2hleGFnb24vbWFjaGluZS5jCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vaW50ZXJuYWwuaCBiL3RhcmdldC9oZXhhZ29uL2ludGVybmFsLmgKaW5kZXggNWZjODM3
YWUyMjkuLmNkMDZmZjQxZDRmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5o
CisrKyBiL3RhcmdldC9oZXhhZ29uL2ludGVybmFsLmgKQEAgLTMxLDQgKzMxLDggQEAgdm9pZCBo
ZXhhZ29uX2RlYnVnKENQVUhleGFnb25TdGF0ZSAqZW52KTsKIAogZXh0ZXJuIGNvbnN0IGNoYXIg
KiBjb25zdCBoZXhhZ29uX3JlZ25hbWVzW1RPVEFMX1BFUl9USFJFQURfUkVHU107CiAKKyNpZm5k
ZWYgQ09ORklHX1VTRVJfT05MWQorZXh0ZXJuIGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiB2bXN0
YXRlX2hleGFnb25fY3B1OworI2VuZGlmCisKICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCBkMzBlNWI2NGVhYy4uMzA1
OTE5NmJjYWMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9o
ZXhhZ29uL2NwdS5jCkBAIC0zODIsNiArMzgyLDkgQEAgc3RhdGljIHZvaWQgaGV4YWdvbl9jcHVf
Y2xhc3NfaW5pdChPYmplY3RDbGFzcyAqYywgY29uc3Qgdm9pZCAqZGF0YSkKICAgICBjYy0+Z2Ri
X3N0b3BfYmVmb3JlX3dhdGNocG9pbnQgPSB0cnVlOwogICAgIGNjLT5nZGJfY29yZV94bWxfZmls
ZSA9ICJoZXhhZ29uLWNvcmUueG1sIjsKICAgICBjYy0+ZGlzYXNfc2V0X2luZm8gPSBoZXhhZ29u
X2NwdV9kaXNhc19zZXRfaW5mbzsKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIGRjLT52
bXNkID0gJnZtc3RhdGVfaGV4YWdvbl9jcHU7CisjZW5kaWYKICAgICBjYy0+dGNnX29wcyA9ICZo
ZXhhZ29uX3RjZ19vcHM7CiB9CiAKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL21hY2hpbmUu
YyBiL3RhcmdldC9oZXhhZ29uL21hY2hpbmUuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAw
MDAwMDAwMDAwMC4uMmRkOTU0NjZlN2QKLS0tIC9kZXYvbnVsbAorKysgYi90YXJnZXQvaGV4YWdv
bi9tYWNoaW5lLmMKQEAgLTAsMCArMSwzMiBAQAorLyoKKyAqIENvcHlyaWdodCAoYykgUXVhbGNv
bW0gVGVjaG5vbG9naWVzLCBJbmMuIGFuZC9vciBpdHMgc3Vic2lkaWFyaWVzLgorICoKKyAqIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCisgKi8KKworI2luY2x1ZGUg
InFlbXUvb3NkZXAuaCIKKyNpbmNsdWRlICJtaWdyYXRpb24vdm1zdGF0ZS5oIgorI2luY2x1ZGUg
ImNwdS5oIgorCitjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9oZXhhZ29uX2NwdSA9
IHsKKyAgICAubmFtZSA9ICJjcHUiLAorICAgIC52ZXJzaW9uX2lkID0gMSwKKyAgICAubWluaW11
bV92ZXJzaW9uX2lkID0gMSwKKyAgICAuZmllbGRzID0gKGNvbnN0IFZNU3RhdGVGaWVsZFtdKSB7
CisgICAgICAgIFZNU1RBVEVfVUlOVDMyX0FSUkFZKGVudi5ncHIsIEhleGFnb25DUFUsIFRPVEFM
X1BFUl9USFJFQURfUkVHUyksCisgICAgICAgIFZNU1RBVEVfVUlOVDMyX0FSUkFZKGVudi5wcmVk
LCBIZXhhZ29uQ1BVLCBOVU1fUFJFR1MpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMl9BUlJBWShl
bnYudF9zcmVnLCBIZXhhZ29uQ1BVLCBOVU1fU1JFR1MpLAorICAgICAgICBWTVNUQVRFX1VJTlQz
Ml9BUlJBWShlbnYuZ3JlZywgSGV4YWdvbkNQVSwgTlVNX0dSRUdTKSwKKyAgICAgICAgVk1TVEFU
RV9VSU5UMzIoZW52Lm5leHRfUEMsIEhleGFnb25DUFUpLAorICAgICAgICBWTVNUQVRFX1VJTlQz
MihlbnYudGxiX2xvY2tfc3RhdGUsIEhleGFnb25DUFUpLAorICAgICAgICBWTVNUQVRFX1VJTlQz
MihlbnYuazBfbG9ja19zdGF0ZSwgSGV4YWdvbkNQVSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMy
KGVudi50bGJfbG9ja19jb3VudCwgSGV4YWdvbkNQVSksCisgICAgICAgIFZNU1RBVEVfVUlOVDMy
KGVudi5rMF9sb2NrX2NvdW50LCBIZXhhZ29uQ1BVKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIo
ZW52LnRocmVhZElkLCBIZXhhZ29uQ1BVKSwKKyAgICAgICAgVk1TVEFURV9VSU5UMzIoZW52LmNh
dXNlX2NvZGUsIEhleGFnb25DUFUpLAorICAgICAgICBWTVNUQVRFX1VJTlQzMihlbnYud2FpdF9u
ZXh0X3BjLCBIZXhhZ29uQ1BVKSwKKyAgICAgICAgVk1TVEFURV9VSU5UNjQoZW52LnRfY3ljbGVf
Y291bnQsIEhleGFnb25DUFUpLAorCisgICAgICAgIFZNU1RBVEVfRU5EX09GX0xJU1QoKQorICAg
IH0sCit9OwotLSAKMi4zNC4xCgo=

