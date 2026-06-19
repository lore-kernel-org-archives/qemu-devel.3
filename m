Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64482CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waifR-0003rQ-62; Fri, 19 Jun 2026 19:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifO-0003pf-MZ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifM-0007QI-FQ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:30 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLY81G1369194
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WYScGZeBQb/FybxxD9F89fJ15bRXNrsuCqPgSPyLkDw=; b=NtizHW+aR/wX1B/o
 pJLmNi4ERilD9PRBFwNQducshg3dBn5/VDogEHbAkW8iF3vbOAdZmfLTo2SkutrJ
 JNAfQ1n9n5aFId5VQFZBlo9Z+OAUn4U/jj+OyBnpcKhvEGEtkOQBqmBEMiLLYx1i
 V4bxwcMl2q5HB6pv1m7TukIV/omyJF5Z4IIH3P0BwZJZEpH4bnO0WW1YKZfkRpmL
 tFI6cwrWMoar1eGgVzx4HcD4K9piqzjg8XCGBTz8cZSCQmWOyWFgj18ZoyQIJT5/
 Vxiu04J9MuZoAQXW/9d5r0qJTRZmwbZsRHcn1PB2HteXB1WhPqxzF7j+BVD/b5fJ
 4HL2SQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewcy30dwq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:27 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1384427c3efso9179928c88.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781911826; x=1782516626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WYScGZeBQb/FybxxD9F89fJ15bRXNrsuCqPgSPyLkDw=;
 b=ZQ57Tsdds/9MscAwzFrTdIwYn93u22Xtsztd01HtxV251elT/WXr6fdGI9pmYOp33M
 FFVth/SpX4nSAvrGNalbkGqZHW4xFGmSmGfZdjkTDFVOVGEC4LDsebwErUIqO2/csV+m
 7mynJq4o03v/1+Vhhe+skpZnPETi8428T4pLGo39zag/m4syHoDNwl94uFgAGodjqP4L
 Mi49HI1zfC6q1QNGeNOUCeKPI9AooAF0++y7ElBGWNvW8kmQO/DPSPVbUavlZmYYzL94
 NKDy168K8yEJ1fLhEHAgZ7bqr4EHOh15MoqspTgjsAtgRewKIBUjYh0Sle9/zXwOxrTh
 tmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781911826; x=1782516626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WYScGZeBQb/FybxxD9F89fJ15bRXNrsuCqPgSPyLkDw=;
 b=dBFn1pNnF2f7BlGTxpmeqDexee3p+NanIV3bpsZnlJzfgdU1CwnbkICCJQP0ro2SUM
 aYi9OSJMV108XCia45n1KNeVjPe+Dbchmadh5ypz5o7p5Gb4CmDI2M5mI106ddWYC6YQ
 Tm1IYjNTsLuxJfTsBgbJ8BlwMCPwxzJ+XKkOYRQ5d+q6QFvMh4QtT5BOQNFPIwMReMDM
 Lx2hKD8QOC6R+D+gXTkITc0ok2gfHdSc/ieSMNNbEGKbdhGpIHN3KygU/oLMpWO2oYFE
 5uEdMuuSL24L4kTR3pro7opqEvPmH90+3Zq2pGqynnTqa8RtcLn/OTr7ctDH5s51+8Ol
 Xfbw==
X-Gm-Message-State: AOJu0YzVeJvCSa10fPzo+McX8lTicmdUKzfJF0NwSVOtKFmOcHMhTApk
 TaX0LPoxf3dlQxYgXZvOil4AbAqgTXDo8II+DfIOlH0ZrGS/58Ve4cQloUT/U2qfXLLubGwFGwh
 RaIgc1l9GJuXAAbAQey1W6Oku4ctBPN10xq/izUGS+1eZm9Q7eTOcLUPGi/wsEu7R3Q==
X-Gm-Gg: AfdE7ckpAKF6ucFuCYWtsBDiI7NUD6CXKiFL0hf4qVb/Rs1SCtptGPdFnHpdO580cEI
 rtdhMG+2nV6qY6Sj8SOS+nvCx+E0NmW8JEhPyxQGpKAE9ABbGUdAYpyibp8+SghHZHb1YNbEdyU
 VJ5uz61a3joReudEXqEbhRPpPgAuwYJbvi6cysMD1hJgKj6IbLuT9Iwjc+5VMaq1XRD3Gb1Caza
 ORf8ruRQ+XkwKjhI74V8zJ7z3GucpXjQkWxmjNvO2ym7FV5HejniEOxwcGJ24sJRgRp39JvBfo1
 siR9rnJpAoLRHMgeXDE+OuqsLVcM6uMf/QIR4Rfk2ER8AC+A30FRBwNhttOhAuiIQGfWQcXsEk4
 1wrKYvCZCR5QFwUHziOrZqTUBCoIbqrlw7iv6foNvKMzDyZ0HMG7sWkl2yys=
X-Received: by 2002:a05:7301:19ac:b0:2e2:3381:2fba with SMTP id
 5a478bee46e88-30c0cd3e894mr2224208eec.3.1781911826451; 
 Fri, 19 Jun 2026 16:30:26 -0700 (PDT)
X-Received: by 2002:a05:7301:19ac:b0:2e2:3381:2fba with SMTP id
 5a478bee46e88-30c0cd3e894mr2224199eec.3.1781911825965; 
 Fri, 19 Jun 2026 16:30:25 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm1212646eec.15.2026.06.19.16.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:30:25 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 49/74] target/hexagon: Implement siad inst
Date: Fri, 19 Jun 2026 15:58:46 -0700
Message-Id: <20260619225911.159473-50-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: fc5BYUYqwC5mLdho9Qb-DFL0oRshSRNB
X-Proofpoint-ORIG-GUID: fc5BYUYqwC5mLdho9Qb-DFL0oRshSRNB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX3kvNkFcH0MC+
 eppRjGtdv+nQicgv6OVpEfZspPSRiZhkc3KEOpOS7XS7W4aB98/9/HqUKpAPnOZLbARcR0mxecs
 dddCDIsLOyEJ9xQ+ZRJiqQMDfrSAuMFT9zXWaeeKMDlK5RzggUM5RB1NFrFeHL0Ox5B2wvEVUmR
 cs7F8pkKTO/6NR6DozBm7wOM8k6WzfOLAEyWUzqqiWs6LvSs8xHJJOt6m+Y0O6bYBIOFP0iNHP+
 SLTymqZ+b6QxdXfhvrSemxP4Xe6oQettM8KI7Vl83vEdiU+pLCMTAHF6wt4nfDddVua+g3p1dZY
 geG4MU//kwWBYsqcyag5bMNdYX5tpcOu1z0n7a+5RYwTAVVxccy6++DFUhCr97oQkXtZKjeXLDl
 9E8VAX2PD1p2tLFMwO6cYV1dscXN64mV7b+4oKOP6Le6jLpZ06kmwebmKZ6d4PWuClFWcJcp9AH
 3zkooe6cgQCN2xg7lEA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfXw2AFaNjFCG5B
 6eFhu0OeEP2UVIqz9FsnHI3Fp8ia755OtHn8kFpn8j0TStpUe5kCDVsdabhxFjSeXLtmIMcWgvP
 jkyKx+Z3/xS+iOEJF0Zsv8OK/4SjXLM=
X-Authority-Analysis: v=2.4 cv=ZOvnX37b c=1 sm=1 tr=0 ts=6a35d113 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=HdTxHAvixyPUp6pof0EA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190226
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpzaWFkIGlzIHRoZSAnU2V0IGlu
dGVycnVwdCBhdXRvIGRpc2FibGUnIGluc3RydWN0aW9uLgoKUmV2aWV3ZWQtYnk6IFRheWxvciBT
aW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENh
aW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9o
ZWxwZXIuYyB8IDE3ICsrKysrKysrKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hl
bHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggYThiZjg5YWI5OTYuLjRk
MzE5YTI2MzdmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90
YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMTQzNiw3ICsxNDM2LDIyIEBAIHZvaWQgSEVM
UEVSKGNpYWQpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBtYXNrKQogCiB2b2lkIEhF
TFBFUihzaWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykKIHsKLSAgICBn
X2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIHVpbnQzMl90IGlwZW5kYWQ7CisgICAgdWludDMy
X3QgaWFkOworICAgIEhleGFnb25DUFUgKmNwdTsKKworICAgIEJRTF9MT0NLX0dVQVJEKCk7Cisg
ICAgY3B1ID0gZW52X2FyY2hjcHUoZW52KTsKKyAgICBpcGVuZGFkID0gY3B1LT5nbG9iYWxyZWdz
ID8KKyAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfcmVhZChjcHUtPmdsb2JhbHJlZ3MsIEhFWF9T
UkVHX0lQRU5EQUQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJ
ZCkgOiAwOworICAgIGlhZCA9IGZHRVRfRklFTEQoaXBlbmRhZCwgSVBFTkRBRF9JQUQpOworICAg
IGZTRVRfRklFTEQoaXBlbmRhZCwgSVBFTkRBRF9JQUQsIGlhZCB8IG1hc2spOworICAgIGlmIChj
cHUtPmdsb2JhbHJlZ3MpIHsKKyAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfd3JpdGUoY3B1LT5n
bG9iYWxyZWdzLCBIRVhfU1JFR19JUEVOREFELAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpcGVuZGFkLCBlbnYtPnRocmVhZElkKTsKKyAgICB9CisgICAgaGV4X2ludGVycnVwdF91
cGRhdGUoZW52KTsKIH0KIAogdm9pZCBIRUxQRVIoc3dpKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKLS0gCjIuMzQuMQoK

