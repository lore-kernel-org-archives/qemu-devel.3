Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDE7C5DF88
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 01:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwV9r-0008Jy-IK; Tue, 18 Aug 2026 21:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwV9p-0008Jc-VA
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 21:31:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwV9o-0008Cw-D6
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 21:31:57 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67INlHMQ2604588
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 01:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iSJxhU8x5GMFb0ylWA8mFxaQ/6SX6EcZM6uIRo3bzdo=; b=Fvm/huNzt7SDI8U6
 Hz4IU/20fEhf91Cb4dgLo2i2OsuIGv/KQ1Hsl/69V0Gu1eROt1I1mwv0ec/Mocdk
 dhbjggXsKX00XcrrYbraOTtvH8cMpgNeZoURXZXDej0KLTkN9t8mzM799OxX+rSJ
 yZbnV7NekhwJqE6+HaA5vZsUbTmd+Yi+pMtFa2HrWnjn05ZMOdb29Qi4YXSpu9rh
 U0H/wpvwOT7JJf/yOYIhPgcDFKQqMTjMdM0qmPXGy3hYiHmQo8sbDk5dZnT0s/K/
 cMY1tNQmc+tITPnxYrwReQY1g8TO0nm503R0PwUJNCtYX+AP0RHkzvZjpqCh+ua8
 BbKHqQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfjgt9t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 01:31:54 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cf6acd760cso5743335ad.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 18:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787103114; x=1787707914; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iSJxhU8x5GMFb0ylWA8mFxaQ/6SX6EcZM6uIRo3bzdo=;
 b=A2xmOEauA/oh+r2YJd/F42WcRln8xjyGSc5fI70ya68TOPFPaR/S+cCP24/J1x/vAo
 hx2ikiVyKW3D4FvDB/0YytR6Mu4eF5g4zXC2FtxNpBswQyejHNSO2vg0XWogczCcpUHi
 mxVZqG/CIUxwAlmL5+b1vJB8W8xeWTHp58sjNXjmYYNRWbgsDV0NzLpyFOwmfCzz02Df
 t6jDz2B3geaO7bT48bdfNgh85Nlpm2yN1Lk4WW2f2pBFB0GLH1bx7UrLrThQ8XIEpyLe
 lob4rxye4deHE+dpLrvf7/WPo+tAFBBDQhVru9hw5mDIY9ZwYjXHnzi1vnw9ELpcNes8
 qXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787103114; x=1787707914;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iSJxhU8x5GMFb0ylWA8mFxaQ/6SX6EcZM6uIRo3bzdo=;
 b=myOPxIG14InBwropZJYf7XdAe7uVCz54gHNe404GITX/1Ig06sVe8kJ5VEQNPkTlw/
 t/PB6mObtT+vydj8iqAgslb64L7qexPIYzK45te/2svYm7yt2crtAImCeI1xbV2x6/6Q
 PZxCbUnJZurxddm0CC0Rgqae56V5W503mkvj5DQe2yz0mUgQCAy8bR2BSPLiXPtor/6H
 4U0ykftCxqW3XSr2fMVyMorUNwUH1wa83zuyIHV5xxg5wWo1duWZe4PnlU8n788aTC9O
 YJym8EnBC05OtnVvJuZuQ/OIPy4zOutbzs9BRmIqFJvmAZfM11GqAQwWODcwHSmPNJOv
 lzeg==
X-Gm-Message-State: AOJu0Yz2+cM6kRNg5mn/vc9EevenD4T54hm5zxwunS9PKs4OyN+J+tS+
 ipVXy+FWfOkdY/5dOW1YFZKhctipa5+0offI15MPPaSzpiDnu8bpP4qq3GO5uiLsl/qSKSnPdWu
 6grrGO7iZfnQW7UGtFvkti1Fdh1vlxMooQl84Sz5b4N9OB/ldpTA7uwAyfQ7WzsTdZQ==
X-Gm-Gg: AR+sD11AOI6Od4POnbPf+IcpAqb8LXGiX1lYeVWNPq4uHNIQAcLdPzKqXnSeNCfbNlO
 u/v+SKsCgTjrTZYuLTtZRfORZ+ZoZN7JsUSvYCsc05ornlETUDRT3YFgNL+ssPGZV5KZLTVy+ty
 dpDQ0N5zbGgXPZauaGb0JBQKPQG1M3QTZEtjkRdc0C6rJhxirDTSB7xG/ByLwYkvyIXniF/mXED
 VbLuqyY08s5rSPz2vB8jtM1mM4R4o/DuxPz+Cg05RwP6x0bb7SzBw4AlRdxTVUP7R6xaaiGpRul
 49CWhTwwSydhaTkuDcaPxvmjy8t0et0f4Nn527JR8ABR053y7w2HF7XSl4hrclmhqIgSQGhKWWX
 9P6Jp1kIKTFiPuM24QMfN+vkwAahT3ykYrTLsvnRsD90jMWW9
X-Received: by 2002:a17:902:e802:b0:2ca:ec6f:aeca with SMTP id
 d9443c01a7336-2d5fd6e09a1mr16848885ad.8.1787103113925; 
 Tue, 18 Aug 2026 18:31:53 -0700 (PDT)
X-Received: by 2002:a17:902:e802:b0:2ca:ec6f:aeca with SMTP id
 d9443c01a7336-2d5fd6e09a1mr16848275ad.8.1787103113511; 
 Tue, 18 Aug 2026 18:31:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327befa4b94sm1157539eec.13.2026.08.18.18.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 18:31:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 04/11] target/hexagon: guard writes to unimplemented guest
 registers
Date: Tue, 18 Aug 2026 18:31:37 -0700
Message-Id: <20260819013144.3264096-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
References: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAwOSBTYWx0ZWRfX8jlz+3ZFczGm
 9GuToFsxh/impQveN8KmfmzGKdgW9/sVTFoSdN24SBkp+3pFDMwE5OQysVEPne/xCratmFHRz/c
 I7yUOPPn0ciCBaX45ET8uMo/TmqNaeoSdQKcgxENEeuVQx/mX8uvfDE9No7En/HcRHreRYbVmO1
 A1zqhRRP+qZ1uG5WrB5J07Xd1MDQgXOG+83MnDbJWF1BHlayddDA7AY7b+0PX4FTF5be5BTRK6F
 hYuPLdTYL3Gz94SC6bIwsTAaW9H0vqUG2au+8t/PSPb4Osbd7+nBB4H5+dWiMZvjRapr1sDyqZd
 n1uAEVwAdOZAdnRP1OIBGvzRwm1W2eUrrA1bFxadHWmAaCgL2IpxQZx+Kzps6kZxyV7vZMM903+
 0IHCzSpIgc8w+HvlBJNTpN8v4wtxUgTkXOgXVjjoZ5UmSqg5GUWYleysKXnjeBSDNbONUA1taVS
 9N8IJ3Vyl36XwzQ85yg==
X-Proofpoint-GUID: C45F6VEHvyqK2Zz4t4anNUPDMPiL0tHJ
X-Proofpoint-ORIG-GUID: C45F6VEHvyqK2Zz4t4anNUPDMPiL0tHJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAwOSBTYWx0ZWRfX9s4msFpBm4xE
 nfdx4enkEYtZYuyG/kT9EA2DqXgbZ3VTDPYaxQ0IXIWY7pDCk/6k1gCb1kWusILVejk2rtkJakn
 BFn92pBU2soTAcXRwTHobIp4tLuEkMY=
X-Authority-Analysis: v=2.4 cv=Sb7HsPRu c=1 sm=1 tr=0 ts=6a85078a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=q6_NcmobPIDMa4dJqmQA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_05,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190009
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

R2F0ZSBndWVzdC1yZWdpc3RlciB3cml0ZXMgb24gZ3JlZ193cml0YWJsZSgpIGluIHRoZSBnZW5l
cmF0ZWQgY29kZSBzbwp3cml0ZXMgdG8gZ3JlZ3MgYWJvdmUgRzMgYXJlIGRyb3BwZWQgaW5zdGVh
ZCBvZiBkZXJlZmVyZW5jaW5nIGFuCnVuYWxsb2NhdGVkIFRDRyB0ZW1wLgoKU2lnbmVkLW9mZi1i
eTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9o
ZXhhZ29uL3RyYW5zbGF0ZS5oICAgfCAgNyArKysrLS0tCiB0YXJnZXQvaGV4YWdvbi9oZXhfY29t
bW9uLnB5IHwgMTggKysrKysrKysrKysrKysrKystCiAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vdHJh
bnNsYXRlLmggYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaAppbmRleCAwMGRlMmIwZDJlYy4u
MDU0MjVkOTJiMjkgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCisrKyBi
L3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCkBAIC05Nyw5ICs5NywxMCBAQCBib29sIGlzX2dh
dGhlcl9zdG9yZV9pbnNuKERpc2FzQ29udGV4dCAqY3R4KTsKICNpZm5kZWYgQ09ORklHX1VTRVJf
T05MWQogc3RhdGljIGlubGluZSB2b2lkIGN0eF9sb2dfZ3JlZ193cml0ZShEaXNhc0NvbnRleHQg
KmN0eCwgaW50IHJudW0pCiB7Ci0gICAgYXNzZXJ0KHJudW0gPD0gSEVYX0dSRUdfRzMpOwotICAg
IGN0eC0+Z3JlZ19sb2dbY3R4LT5ncmVnX2xvZ19pZHhdID0gcm51bTsKLSAgICBjdHgtPmdyZWdf
bG9nX2lkeCsrOworICAgIGlmIChybnVtIDw9IEhFWF9HUkVHX0czKSB7CisgICAgICAgIGN0eC0+
Z3JlZ19sb2dbY3R4LT5ncmVnX2xvZ19pZHhdID0gcm51bTsKKyAgICAgICAgY3R4LT5ncmVnX2xv
Z19pZHgrKzsKKyAgICB9CiB9CiAKIHN0YXRpYyBpbmxpbmUgdm9pZCBjdHhfbG9nX2dyZWdfd3Jp
dGVfcGFpcihEaXNhc0NvbnRleHQgKmN0eCwgaW50IHJudW0pCmRpZmYgLS1naXQgYS90YXJnZXQv
aGV4YWdvbi9oZXhfY29tbW9uLnB5IGIvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQppbmRl
eCBlMzNkNDNlM2NlMC4uYzE4MGMxOWIwOTIgMTAwNzU1Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkKKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQpAQCAtMTA5Nywx
MSArMTA5NywyNCBAQCBkZWYgYW5hbHl6ZV93cml0ZShzZWxmLCBmLCB0YWcsIHJlZ25vKToKICAg
ICAgICAgIiIiKSkKIAogY2xhc3MgR3Vlc3RSZWdpc3RlcihSZWdpc3Rlcik6Ci0gICAgcGFzcwor
ICAgIGRlZiBnZW5fY2hlY2tfaW1wbChzZWxmLCBmLCByZWdubyk6CisgICAgICAgIGlmIHNlbGYu
aXNfd3JpdHRlbigpOgorICAgICAgICAgICAgZi53cml0ZShjb2RlX2ZtdChmIiIiXAorICAgICAg
ICAgICAgICAgIGlmICghZ3JlZ193cml0YWJsZShpbnNuLT5yZWdub1t7cmVnbm99XSwKKyAgICAg
ICAgICAgICAgICAgICAge3N0cihzZWxmLmlzX3BhaXIoKSkubG93ZXIoKX0pKSB7eworICAgICAg
ICAgICAgICAgICAgICByZXR1cm47CisgICAgICAgICAgICAgICAgfX0KKyAgICAgICAgICAgICIi
IikpCisgICAgICAgIGVsc2U6CisgICAgICAgICAgICBmLndyaXRlKGNvZGVfZm10KGYiIiJcCisg
ICAgICAgICAgICAgICAgY2hlY2tfZ3JlZ19pbXBsKGluc24tPnJlZ25vW3tyZWdub31dLAorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB7c3RyKHNlbGYuaXNfcGFpcigpKS5sb3dlcigp
fSk7CisgICAgICAgICAgICAiIiIpKQogCiBjbGFzcyBHdWVzdERlc3QoR3Vlc3RSZWdpc3Rlciwg
U2luZ2xlLCBEZXN0KToKICAgICBkZWYgZGVjbF90Y2coc2VsZiwgZiwgdGFnLCByZWdubyk6CiAg
ICAgICAgIHNlbGYuZGVjbF9yZWdfbnVtKGYsIHJlZ25vKQorICAgICAgICBzZWxmLmdlbl9jaGVj
a19pbXBsKGYsIHJlZ25vKQogICAgICAgICBmLndyaXRlKGNvZGVfZm10KGYiIiJcCiAgICAgICAg
ICAgICBUQ0d2X2kzMiB7c2VsZi5yZWdfdGNnKCl9ID0gdGNnX3RlbXBfbmV3X2kzMigpOwogICAg
ICAgICAiIiIpKQpAQCAtMTEyMSw2ICsxMTM0LDcgQEAgZGVmIGRlY2xfcmVnX251bShzZWxmLCBm
LCByZWdubyk6CiAgICAgICAgICIiIikpCiAgICAgZGVmIGRlY2xfdGNnKHNlbGYsIGYsIHRhZywg
cmVnbm8pOgogICAgICAgICBzZWxmLmRlY2xfcmVnX251bShmLCByZWdubykKKyAgICAgICAgc2Vs
Zi5nZW5fY2hlY2tfaW1wbChmLCByZWdubykKICAgICAgICAgZi53cml0ZShjb2RlX2ZtdChmIiIi
XAogICAgICAgICAgICAgVENHdl9pMzIge3NlbGYucmVnX3RjZygpfSA9IHRjZ190ZW1wX25ld19p
MzIoKTsKICAgICAgICAgICAgIGdlbl9yZWFkX2dyZWcoe3NlbGYucmVnX3RjZygpfSwge3NlbGYu
cmVnX251bX0pOwpAQCAtMTEzMSw2ICsxMTQ1LDcgQEAgZGVmIGFuYWx5emVfcmVhZChzZWxmLCBm
LCByZWdubyk6CiBjbGFzcyBHdWVzdFBhaXJEZXN0KEd1ZXN0UmVnaXN0ZXIsIFBhaXIsIERlc3Qp
OgogICAgIGRlZiBkZWNsX3RjZyhzZWxmLCBmLCB0YWcsIHJlZ25vKToKICAgICAgICAgc2VsZi5k
ZWNsX3JlZ19udW0oZiwgcmVnbm8pCisgICAgICAgIHNlbGYuZ2VuX2NoZWNrX2ltcGwoZiwgcmVn
bm8pCiAgICAgICAgIGYud3JpdGUoY29kZV9mbXQoZiIiIlwKICAgICAgICAgICAgIFRDR3ZfaTY0
IHtzZWxmLnJlZ190Y2coKX0gPSB0Y2dfdGVtcF9uZXdfaTY0KCk7CiAgICAgICAgICIiIikpCkBA
IC0xMTUwLDYgKzExNjUsNyBAQCBkZWYgZGVjbF9yZWdfbnVtKHNlbGYsIGYsIHJlZ25vKToKICAg
ICAgICAgIiIiKSkKICAgICBkZWYgZGVjbF90Y2coc2VsZiwgZiwgdGFnLCByZWdubyk6CiAgICAg
ICAgIHNlbGYuZGVjbF9yZWdfbnVtKGYsIHJlZ25vKQorICAgICAgICBzZWxmLmdlbl9jaGVja19p
bXBsKGYsIHJlZ25vKQogICAgICAgICBmLndyaXRlKGNvZGVfZm10KGYiIiJcCiAgICAgICAgICAg
ICBUQ0d2X2k2NCB7c2VsZi5yZWdfdGNnKCl9ID0gdGNnX3RlbXBfbmV3X2k2NCgpOwogICAgICAg
ICAgICAgZ2VuX3JlYWRfZ3JlZ19wYWlyKHtzZWxmLnJlZ190Y2coKX0sIHtzZWxmLnJlZ19udW19
KTsKLS0gCjIuMzQuMQoK

