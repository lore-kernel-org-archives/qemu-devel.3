Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B4ACDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcksy-0006du-CD; Thu, 25 Jun 2026 10:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcksv-0006dU-MS
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:16:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wcksu-0008QQ-5H
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:16:53 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9jt652009522
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PhlMi1XNwmwGtcu38VtvVt8mGfYfYfXO6/8xhorQDxo=; b=cB0UaQ9p45vbUcRc
 S6h5/c565G4KcD6x/MCvAKo1ofWP0qkKjZlLCSQKf8Ltu9gp1vAq74mMh83LS+Xl
 YRpCpWx0BJDMB8r9rhFi4B4bfLG2s9eRrcXLiRxXzytn+uhPV1dbdhg/7+gJKG7R
 a2bKjjFod2xfWrSD+0TzSiI2pnks8O2LF67Ifl0p7jksLpib4RVtYXR4KwcnX5at
 WZQxtizYtxuSja6v9UFdr+SlZnBWR/0vYFA7DF7vdZxrOt0HC/BHAhh0W8Kev4xh
 OQufWiGrlWPz7CREbhsOjP6Edp5Proi+nc77jlLzZGSdjouVE9KQ8nQQ/pup0gD3
 Wx8Mhw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0uhmjjue-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:16:51 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c8d355dbcso1437507eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782397010; x=1783001810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PhlMi1XNwmwGtcu38VtvVt8mGfYfYfXO6/8xhorQDxo=;
 b=cpLC2iGIlwNtzWtMSCdghdnMvF2y8adP6j6jcI5TAjgfZvUt5kcUKn9bUiHNZInNSl
 dHPXXQ2OR0iiuGjoPLW+xj5d8AqX+ajOnTFEheBgUO53xZz6cMXSZYPlGkSYMYvUaU4J
 ZV+HlUVWQl8EVvkPVI6zlgdp00fkCaOWSEXmSZZ9klBvV48Cqoxi3Pmek0lhCu8EHhWL
 x7eMg1sLConSOqnXUtdQFXeiyuLz+kvHU1nabhGPqpfX0TyQ0EzyRvl+TXCHuoynml2V
 h8bXeNR3IOIeAr4rn+32byrWYD3mULysIJC3DcfJ0qyuOHaPDBOYAuWtWYSI9QEHGm6Q
 eLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397010; x=1783001810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PhlMi1XNwmwGtcu38VtvVt8mGfYfYfXO6/8xhorQDxo=;
 b=f7aQNSGDDj0JTZnLHQCSi4U26+QaG7P0wPzS96cv9Dqf3AvTX01T0E0IbF+QMGHrIO
 bF2jd0/2DaJHFdrjUwsgSilg5NOepFG/c79i5gXrxKQl4Z78pDylvVQbH+RuP92rP1Eu
 gehY88N3p7toMtRHvlVw600zaX+jD5poAQzNWsqQ5POG8c53LGqTRTubBqLmqbLuYLVu
 X0Bmbg7Fnhaq4iJrk27Fen3rmlWhUkuIP5sy5VcACA9KecL3S1rt5foWIIjrgFdt4QN4
 w64aT6m+/1Sme66nusf57ZRFrUuXydfLTX5+FjDwZKlANoaJM16gu5m3k/iZJlfua59+
 ErLg==
X-Gm-Message-State: AOJu0YydXORVmj4ndH6UqMQjFhRkpITJZW0OSxn/A/cG4PQ7gn+sELD1
 bfiYaCyBt07e/Le6OLEcTa9PhI/RRHa5rT+Iv4yV5MqtvCvL76ARP1HrAMMyQKynFvI4D/rhHbq
 E6rQRBrOdNBbiLD72GRDi37eXOFoBQyQ0yML6m2zW5qFkUFU14Zy5B7rDbdMGKsSFMw==
X-Gm-Gg: AfdE7cksuLS402WVsGg8Sr2GbCv58C68UnEtldBaNRRwXhQBbqm7MSWL4hIQXCXXfTU
 Aya8tIRewTVzS8p1IHCqVdB+e+cVy47sxobPBupUZPfa/hbY1n0CzCaMQCtToSlLd+Uj9JDOLmC
 gnJaDsWFf+BBL+N2MV0kKsTewdpxICL1Rw6NK2X6hdre6qZwlN4OIIVUWIFdGs+KuglJsg6TyMl
 ewmD+R/ni62qBvlMy5PJjYvUP4Fu7t/3Xa0ceKlmMGARWWVYWFGrrdRvMcRglBB6UyunsYgRodP
 sMdIoxH3kerwLymTixLPHwG9Sak0dcX8LaRkdSOmgY9qDfMIUqtTFDY/kz4DlkASvw2lwVURucw
 Y16mMxqNdNKEfubuaWKGCSllyO2eERSIzFSpXh15dpEu7AY0bYhvCaokfsYA=
X-Received: by 2002:a05:7301:d8c:b0:30b:c502:23df with SMTP id
 5a478bee46e88-30c84bae4e8mr3005236eec.13.1782397010235; 
 Thu, 25 Jun 2026 07:16:50 -0700 (PDT)
X-Received: by 2002:a05:7301:d8c:b0:30b:c502:23df with SMTP id
 5a478bee46e88-30c84bae4e8mr3005158eec.13.1782397009463; 
 Thu, 25 Jun 2026 07:16:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ae5sm10168446eec.16.2026.06.25.07.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:16:48 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 05/76] docs/system: Add hexagon CPU emulation
Date: Thu, 25 Jun 2026 07:15:22 -0700
Message-Id: <20260625141633.449487-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=cqerVV4i c=1 sm=1 tr=0 ts=6a3d3853 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=14gtCLEoMj5qQ5-DTC4A:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfXxAb/vublHoxA
 akYiyEZg/e+b3cpqh0mSsEvBW1/HgIATIm9Pv5ZlHSh2c6Lll+Jbw8/UmfN3jClU/fCFaKMNQ4Z
 6e85ISKLeTGh3SV+dDWaouT1tWmHrIGtuOGZzmwwWD1nrRq7TJ6P+96empUPA1c0RQHvyaCPHHu
 2hfLatmh24w/bp3vYmjsXoRyRnV0pCpX62rATjTt0JOGKKTkAbpRUuXaJnar0Mu/t4sadP9jTk6
 8Ko4394I8z4pp4ScGT2ss1eiP2/pNl2uvUZ4HZZXYT8LkOgy4lGhGqTvXAfnKyrGrmEflp7+1zM
 8NADfNGWDzos1JcESjHggfbUpMsIFd5Gfwm4FdoFNx0slekG8noAMcEy579gwme1rA74rs4hrKf
 9q7vrRBg44quFqKRT9YCw3gLmHx4e7kWAG8Xxrx3HddoVRya+ivPK5TSkmbrdP90DUSIkrWCdP4
 mqPVoGtGhiGmNSQomXw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyMiBTYWx0ZWRfXyufUQ/c678JU
 rZFJa6Q1mJQwTcoSEpIaiUm3/TqJjkfd8KgyMbtEqngg9iv2WsX2RgaB/2VPU+koCDe705g0Ajt
 yqnAaeMQkyBb9dqRR+p1oixBIUP4KQ4=
X-Proofpoint-GUID: Pii0YmcPJuHHV_KusoUY6-WgY9G1x8V2
X-Proofpoint-ORIG-GUID: Pii0YmcPJuHHV_KusoUY6-WgY9G1x8V2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250122
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGRvY3Mvc3lzdGVtL2hleGFn
b24vZW11bGF0aW9uLnJzdCB8IDE1ICsrKysrKysrKysrKysrKwogZG9jcy9zeXN0ZW0vdGFyZ2V0
LWhleGFnb24ucnN0ICAgIHwgIDIgKysKIDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygr
KQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRvY3Mvc3lzdGVtL2hleGFnb24vZW11bGF0aW9uLnJzdAoK
ZGlmZiAtLWdpdCBhL2RvY3Mvc3lzdGVtL2hleGFnb24vZW11bGF0aW9uLnJzdCBiL2RvY3Mvc3lz
dGVtL2hleGFnb24vZW11bGF0aW9uLnJzdApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAw
MDAwMDAwMC4uMzZmNTRmMDU4YWYKLS0tIC9kZXYvbnVsbAorKysgYi9kb2NzL3N5c3RlbS9oZXhh
Z29uL2VtdWxhdGlvbi5yc3QKQEAgLTAsMCArMSwxNSBAQAorLi4gU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKKworLi4gX0hleGFnb24gRW11bGF0aW9uOgorCitIZXhh
Z29uIENQVSBhcmNoaXRlY3R1cmUgc3VwcG9ydAorPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KKworUUVNVSdzIFRDRyBlbXVsYXRpb24gaW5jbHVkZXMgc3VwcG9ydCBmb3IgdjY1LCB2
NjYsIHY2NywgdjY4LCB2NjksIHY3MSwgdjczLgorSXQgYWxzbyBoYXMgc3VwcG9ydCBmb3IgdGhl
IGZvbGxvd2luZyBhcmNoaXRlY3R1cmUgZXh0ZW5zaW9uczoKKworLSBIVlggKEhleGFnb24gVmVj
dG9yIGVYdGVuc2lvbnMpCisKK0ZvciBpbmZvcm1hdGlvbiBvbiB0aGUgc3BlY2lmaWNzIG9mIHRo
ZSBIVlggZXh0ZW5zaW9uLCBwbGVhc2UgcmVmZXIKK3RvIHRoZSBgUXVhbGNvbW0gSGV4YWdvbiBW
NzMgSFZYIFByb2dyYW1tZXIncyBSZWZlcmVuY2UgTWFudWFsCis8aHR0cHM6Ly9kb2NzLnF1YWxj
b21tLmNvbS9idW5kbGUvcHVibGljcmVzb3VyY2UvODAtTjIwNDAtNTMucGRmPmBfLgpkaWZmIC0t
Z2l0IGEvZG9jcy9zeXN0ZW0vdGFyZ2V0LWhleGFnb24ucnN0IGIvZG9jcy9zeXN0ZW0vdGFyZ2V0
LWhleGFnb24ucnN0CmluZGV4IDY1ODY2Mjk2NzI0Li40MTZiOGY3YmU3NiAxMDA2NDQKLS0tIGEv
ZG9jcy9zeXN0ZW0vdGFyZ2V0LWhleGFnb24ucnN0CisrKyBiL2RvY3Mvc3lzdGVtL3RhcmdldC1o
ZXhhZ29uLnJzdApAQCAtOTgsNCArOTgsNiBAQCBpcyBub3QgeWV0IGltcGxlbWVudGVkIGluIFFF
TVUgaGV4YWdvbi4KIEhleGFnb24gRmVhdHVyZXMKID09PT09PT09PT09PT09PT0KIC4uIHRvY3Ry
ZWU6OgorICAgaGV4YWdvbi9lbXVsYXRpb24KICAgIGhleGFnb24vY2RzcAorCi0tIAoyLjM0LjEK
Cg==

