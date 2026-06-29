Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C51C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we39B-0001Zf-Nj; Sun, 28 Jun 2026 23:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39A-0001YQ-7n
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we398-0006Df-5K
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:58:59 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2d0pd1550016
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lcxOkFKNgQXZO0voxWGA9hyffwnAo/o2WwcbX7ewzeA=; b=Wsrv7JIIc2LljyPL
 c2w1Sl0SAgXkj2EjT5Zisgma4kzJhJOQO/5J0y3aZMhRlFgWPZNB2kUvB8/Ou/VD
 GNf/03ELnrl1YfKjkJybyyT65MFFCi+V53oLRFhzGLTQoXWvibbgmlpxszlkB5pW
 WxNa8i6PctpypjlGkI+S+6B536dicaZnfmXC6C5TbYgEClugiSnw3Z89vNcnDmEU
 AbEKzic9bITNgUBFIcePeetHkkOcSp7P8R2g/Rr3u29v2gOrEr4l/1+IN1E+9Whf
 hHwXol/k0TJ8J6r2OBh+niMvD3AQxXMKS5p2MNAuaxQrH56jO2u16cFYXzN+ccY+
 BbxSYA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26x8mdrc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:58:57 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-139c6673856so4500068c88.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705536; x=1783310336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lcxOkFKNgQXZO0voxWGA9hyffwnAo/o2WwcbX7ewzeA=;
 b=Wq1LUa3HvkzcyTnodrRmf1vSWx+qADyuqyMquSDFHIkHTYycaT5EZHjqZ74Ms2UUa7
 eEdR8B5XRGO9rHxhG/6rN+rWY6KGdFhm8U1flJ8sEODKOCRz2NCavZQyKeV4MEgPizQ6
 +tQKa/xJ9s5a6aFPNzMg8PQ8mHvtBeeeVa2gDdRXs1OtgTdqe//u29+duVvNlxQlBoxt
 HY9hPzUQ242fVNoHrxmPF9A2axxc8t5Bu5sdxpTbuByyENB+d3VR5ItOX1rsmY2GVxP+
 P4XVLTf3wMC4o585/kg0hdbR0aQoy2CuT8l/W/pp9Pbexl2tCuYdgP84fLXV2DeUK2eF
 SSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705536; x=1783310336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lcxOkFKNgQXZO0voxWGA9hyffwnAo/o2WwcbX7ewzeA=;
 b=c8f6wM145Mw6ZnGO19X9qCGmol84F26wtdJA+yLiEI/d4yuTtCI7Z+tZSfF2w8GGCT
 11I3rz4fdWJjoZ5koJnoeIJrnO60OOuoPjObZNlzapYXn6OVP69AINCQPPcf3LzxtyLn
 D15Rx0zfUtMO17mxY+echMKcw7eoAuFBuHzcDh20Gt65Yl/OJXCwI2ndU2IYzPziB1My
 H+mrAg2f8jPRgMFeJYT/EsO5q4+8FjuIun6XAfe2nZan/CSlm7hV6TvYob14W7ASHsnc
 cAXRr2gud9ktjBUzD9szMrexZix2Lf1IF5s9I4cUiNbbP67KI0t/X9FPJJbIqlOSb68Q
 +Fsw==
X-Gm-Message-State: AOJu0YyoMIquyjw27WY5ZKROcQdwHvbEL8iNQiL6d9uuZ2z+4rSwCagL
 bnshGouDfVaKbG8cSldQ/phGAasSS3cmtsgiGh8EBc9cVS2Gg+VfUFtELAxBQpPamRxh++p4U2q
 fMwHpI6ridErQjY7/Snq1iuVFQsnaiXObufLhUNJRmSWDmKWGpfOeA7FzZ8+yX9m7yQ==
X-Gm-Gg: AfdE7cl2ize0vm0qbtUeYWlnXq3iWimdao0YGsGlbsomkCKHDMkNc80jdBtANTvUr9m
 Hiw0yEv4BhAVCDIi2xpa1G+5E38P0RPtD2+uiPhrNhYWwVk83qUuNa1A5b1gfD/D6JqTIJPTmoI
 pzebRPMRgYszCiOhrEA2rKmeKtn5+uxdIOOMeLeiUPACqiVLND1A6MaCTP+lNkpM92/M7GYJYJ1
 0v8vWG82iMDDPcAD9crrbiD5WS5NdatSLk+N5d2QqhAbmSPfnZNkYaBAA6vFDueUQojPp6dB1zt
 yFHU14DcSj37JRKcyzF9+qG59jvP2GiLb3Oy221cchjnuiY2IiIEUpu9BNObl3NRhDZB6cEHJfc
 Te0EvMLvjBZuFNq0On7t0ZUMzXE/3+jNAcfWQWm0dF7w81g3KYdzz7XP8tc0=
X-Received: by 2002:a05:7023:b88:b0:138:3613:dbb with SMTP id
 a92af1059eb24-139db9e7c2bmr13259139c88.5.1782705536133; 
 Sun, 28 Jun 2026 20:58:56 -0700 (PDT)
X-Received: by 2002:a05:7023:b88:b0:138:3613:dbb with SMTP id
 a92af1059eb24-139db9e7c2bmr13259114c88.5.1782705535608; 
 Sun, 28 Jun 2026 20:58:55 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:58:54 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 10/77] target/hexagon: Suppress unused-variable warnings for
 sysemu source regs
Date: Sun, 28 Jun 2026 20:57:23 -0700
Message-Id: <20260629035830.1520296-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX5gfYsrW0eh0+
 FiviSDoGEaJzaLVQXYhRFOUwyGxA8bfjNXrIOAS7MrYR8JrL3UWDSNc48Y2xjvD+dKxU6DymbO7
 g+zDPi9KHq4Nigx7Y2SkH7X6vpyLtJE=
X-Authority-Analysis: v=2.4 cv=D+N37PRj c=1 sm=1 tr=0 ts=6a41ed81 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=dvhcR3axvtdXbCCTPW8A:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: adw_8OdITHHrqr_1ahXCqvH-QmbTWFJ2
X-Proofpoint-ORIG-GUID: adw_8OdITHHrqr_1ahXCqvH-QmbTWFJ2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX4yhwbtD2oAzc
 G8rswMBbOpDce6NojreG918YvqEw5Kxis2aLizD1wYX/Ej2EjjwrzYzHqDK2ZuvWo8iTHySkQ6U
 ym5A5Dwar6lLo0WJrf7ej7+xIoDudlnCOhbONw9BY7LamSNwiSwhgeiwG4y/WGr0fPv57kjCAAC
 /x8hFjMEC7B0VKbHRtt6mI5ucaxQOzp7LMio5nDWM6otjbFLKBkxM+knPm/u+QEJN6xP8+N+w7u
 S+GyYaUCqtLzIg8sc7yoi6XmOCv9i2IfqPvn5bkXrD7/HhFFXJpDWW8r34/s6/dUPhtlqGl5P4D
 1zrnuZfnZmwMt4UVd5+Mj2r4ixKELDqFN5E1iqS9DGaHqXwAQUrSemLPcMWvB0sU6BXQ2rnkYyz
 pOD22AZj0szla+FDbYgIhJpOg1/ocWLT4Nljq+wpMakURdPch0KX+YU/JLa7NXbnOMguKj+FGVn
 X/pBZfPyFdjbE/PJCbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290031
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

VGhlIGFuYWx5emVfcmVhZCgpIG1ldGhvZHMgb24gR3Vlc3RTb3VyY2UsIEd1ZXN0UGFpclNvdXJj
ZSwKU3lzdGVtU291cmNlLCBhbmQgU3lzdGVtUGFpclNvdXJjZSB3ZXJlIG5vLW9wcyBiZWNhdXNl
IHRoZXNlCnNvdXJjZSByZWdpc3RlcnMgZG8gbm90IG5lZWQgcmVhZC10cmFja2luZyBpbiB0aGUg
YW5hbHl6ZSBwaGFzZS4KSG93ZXZlciwgZ2VuX2FuYWx5emVfZnVuY3MucHkgdW5jb25kaXRpb25h
bGx5IGRlY2xhcmVzIHRoZQpyZWdpc3Rlci1udW1iZXIgdmFyaWFibGUgKGUuZy4gR3NOKSB2aWEg
ZGVjbF9yZWdfbnVtKCkgZm9yIGFsbApyZWdpc3RlcnMgdGhhdCBhcmUgcmVhZCBvciB3cml0dGVu
LiAgV2hlbiBidWlsZGluZyB3aXRoCmhleGFnb24tc29mdG1tdSwgdGhlIGdlbmVyYXRlZCBhbmFs
eXplIGZ1bmN0aW9uIGJvZGllcyBhcmUKY29tcGlsZWQgKG91dHNpZGUgdGhlICNpZm5kZWYgQ09O
RklHX1VTRVJfT05MWSBndWFyZCksIGFuZCB0aGUKZGVjbGFyZWQtYnV0LXVucmVmZXJlbmNlZCBy
ZWdpc3Rlci1udW1iZXIgdmFyaWFibGUgdHJpZ2dlcnMKLVdlcnJvcj11bnVzZWQtdmFyaWFibGUg
dW5kZXIgYm90aCBnY2MgYW5kIGNsYW5nLgoKT3ZlcnJpZGUgZGVjbF9yZWdfbnVtKCkgaW4gZWFj
aCBjbGFzcyB0byBkZWNsYXJlIHRoZSByZWdpc3RlciBudW1iZXIgd2l0aApHX0dOVUNfVU5VU0VE
LCBzdXBwcmVzc2luZyB0aGUgd2FybmluZy4KClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8
bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlh
bi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5w
eSB8IDE2ICsrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weSBiL3RhcmdldC9oZXhh
Z29uL2hleF9jb21tb24ucHkKaW5kZXggNzk0MzZlZTI5ZDcuLmRmOGQzYmE2NTg2IDEwMDc1NQot
LS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CisrKyBiL3RhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkKQEAgLTEwNjgsNiArMTA2OCwxMCBAQCBkZWYgYW5hbHl6ZV93cml0ZShzZWxm
LCBmLCB0YWcsIHJlZ25vKToKICAgICAgICAgIiIiKSkKIAogY2xhc3MgR3Vlc3RTb3VyY2UoR3Vl
c3RSZWdpc3RlciwgU2luZ2xlLCBPbGRTb3VyY2UpOgorICAgIGRlZiBkZWNsX3JlZ19udW0oc2Vs
ZiwgZiwgcmVnbm8pOgorICAgICAgICBmLndyaXRlKGNvZGVfZm10KGYiIiJcCisgICAgICAgICAg
ICBjb25zdCBpbnQge3NlbGYucmVnX251bX0gR19HTlVDX1VOVVNFRCA9IGluc24tPnJlZ25vW3ty
ZWdub31dOworICAgICAgICAiIiIpKQogICAgIGRlZiBkZWNsX3RjZyhzZWxmLCBmLCB0YWcsIHJl
Z25vKToKICAgICAgICAgc2VsZi5kZWNsX3JlZ19udW0oZiwgcmVnbm8pCiAgICAgICAgIGYud3Jp
dGUoY29kZV9mbXQoZiIiIlwKQEAgLTEwOTMsNiArMTA5NywxMCBAQCBkZWYgYW5hbHl6ZV93cml0
ZShzZWxmLCBmLCB0YWcsIHJlZ25vKToKICAgICAgICAgIiIiKSkKIAogY2xhc3MgR3Vlc3RQYWly
U291cmNlKEd1ZXN0UmVnaXN0ZXIsIFBhaXIsIE9sZFNvdXJjZSk6CisgICAgZGVmIGRlY2xfcmVn
X251bShzZWxmLCBmLCByZWdubyk6CisgICAgICAgIGYud3JpdGUoY29kZV9mbXQoZiIiIlwKKyAg
ICAgICAgICAgIGNvbnN0IGludCB7c2VsZi5yZWdfbnVtfSBHX0dOVUNfVU5VU0VEID0gaW5zbi0+
cmVnbm9be3JlZ25vfV07CisgICAgICAgICIiIikpCiAgICAgZGVmIGRlY2xfdGNnKHNlbGYsIGYs
IHRhZywgcmVnbm8pOgogICAgICAgICBzZWxmLmRlY2xfcmVnX251bShmLCByZWdubykKICAgICAg
ICAgZi53cml0ZShjb2RlX2ZtdChmIiIiXApAQCAtMTExOCw2ICsxMTI2LDEwIEBAIGRlZiBhbmFs
eXplX3dyaXRlKHNlbGYsIGYsIHRhZywgcmVnbm8pOgogICAgICAgICAiIiIpKQogCiBjbGFzcyBT
eXN0ZW1Tb3VyY2UoUmVnaXN0ZXIsIFNpbmdsZSwgT2xkU291cmNlKToKKyAgICBkZWYgZGVjbF9y
ZWdfbnVtKHNlbGYsIGYsIHJlZ25vKToKKyAgICAgICAgZi53cml0ZShjb2RlX2ZtdChmIiIiXAor
ICAgICAgICAgICAgY29uc3QgaW50IHtzZWxmLnJlZ19udW19IEdfR05VQ19VTlVTRUQgPSBpbnNu
LT5yZWdub1t7cmVnbm99XTsKKyAgICAgICAgIiIiKSkKICAgICBkZWYgZGVjbF90Y2coc2VsZiwg
ZiwgdGFnLCByZWdubyk6CiAgICAgICAgIHNlbGYuZGVjbF9yZWdfbnVtKGYsIHJlZ25vKQogICAg
ICAgICBmLndyaXRlKGNvZGVfZm10KGYiIiJcCkBAIC0xMTQzLDYgKzExNTUsMTAgQEAgZGVmIGFu
YWx5emVfd3JpdGUoc2VsZiwgZiwgdGFnLCByZWdubyk6CiAgICAgICAgICIiIikpCiAKIGNsYXNz
IFN5c3RlbVBhaXJTb3VyY2UoUmVnaXN0ZXIsIFBhaXIsIE9sZFNvdXJjZSk6CisgICAgZGVmIGRl
Y2xfcmVnX251bShzZWxmLCBmLCByZWdubyk6CisgICAgICAgIGYud3JpdGUoY29kZV9mbXQoZiIi
IlwKKyAgICAgICAgICAgIGNvbnN0IGludCB7c2VsZi5yZWdfbnVtfSBHX0dOVUNfVU5VU0VEID0g
aW5zbi0+cmVnbm9be3JlZ25vfV07CisgICAgICAgICIiIikpCiAgICAgZGVmIGRlY2xfdGNnKHNl
bGYsIGYsIHRhZywgcmVnbm8pOgogICAgICAgICBzZWxmLmRlY2xfcmVnX251bShmLCByZWdubykK
ICAgICAgICAgZi53cml0ZShjb2RlX2ZtdChmIiIiXAotLSAKMi4zNC4xCgo=

