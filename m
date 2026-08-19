Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB92DC5DF7D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 01:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwV9t-0008Kb-Ga; Tue, 18 Aug 2026 21:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwV9q-0008Jq-Qi
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 21:31:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwV9p-0008D5-98
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 21:31:58 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67INkVOJ3834615
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 01:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0KzNKIbFN5S6XgUO3MxM9Q/AITKADiOHgMFY5MOfHHU=; b=L5NGZPV4qD/oT8WU
 DkswaN3WjokQT/V9TNpeyGC4/2/VtlTzWiMR00QvhW9qzZzEObopw7J61SkykEiY
 a+Pu2d/MVvQX/z7ae2NGK+0sVMPVTi4x81Vm/E6WpZkE9N8YCfqDJZzVzOYnBx8R
 gLoqZzWeaSE+Z4f34CfD+F/qeDhn5rX0YqDB9+HG94eLuPIMyazdB4eQ1cpDNaTJ
 56ZlYm1nAgShhrRdqJx8BblTvtDkx1wf0iWcMJpPCdpS5b/lh+GLSFhJv2JfJSnT
 AvZaFavykO2b5bWfxvAsh1gTf/5gZno/6X4vuZ/PSWmejXg8BUGMHhi64czPoXRf
 Bg1Uww==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfm0qr0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 01:31:55 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8488ac68185so1240645b3a.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 18:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787103115; x=1787707915; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0KzNKIbFN5S6XgUO3MxM9Q/AITKADiOHgMFY5MOfHHU=;
 b=fJpvFYiUfiCV83KhPZJHOYPWqSxJq8UPuOqOCKcEU3YE/Fk3log8X6ALQdnl5QKwij
 51r2zE2mxlGEMSp5cN0PXzme4hb/hKvvP5SAGm8G164E2R4/CSYePLv6P2FhgGRQEWk3
 9/kazyhg26ZaXA1ohcSFuPbFV8g6RAG8hY8Xo5W315uNaSfd1+4a9CmpMWT0+/ssJldm
 Nn88xNSWKlXpe0RQWlwuiLOtl7O8VX9S0z31SH2TCR3rwJPPdOhQXypvojKvTE9D86u8
 qiAAZETzTnPhW7Ja0jeleGjFC/RdMO8Yo7jcemflu26re8T3b2VVTzSH/ne5H8ZnWr5H
 Pb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787103115; x=1787707915;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0KzNKIbFN5S6XgUO3MxM9Q/AITKADiOHgMFY5MOfHHU=;
 b=AfV+SVv9G7pQdKblCI2jTUHlPabyGYR3SD6CwXmki8NTseA7VVMQChHw9/ddd67aY2
 E55ogOs4veCW343wZjHFbyIcc0qST0xNbFf7y8wSa94QHT5R3fWlfa7pGqAOhETKbQ01
 aCWfYxKPuO2/LfrMe187gbTqSmzCSgGQ3yawHjFXJcoKgKzlclCVCAOBxR1ov0Orw9Vv
 HdUhBj+LpeACkTP6tpubiKZvGGk5y97ba34c44wmOn97CiH0DfLO4tu2w/rce1BwbkSq
 eCeKhYaTLWgVSzP1Jr8I/SrZhBYM5tA9PZcJmbI3bvXvBbTB/ddCyjKBTNZW0Z3FCzGy
 w9XQ==
X-Gm-Message-State: AOJu0YwS4gO0ErUud1sadvdU+Nl1Rmo1AP0cXnd46tq6wc4IiYy23Qe5
 Hwijk+tPcxUdkf0NSdAhx3OiK1rcI+M9SlRw0QyCvumL2BlQNVQVTK1zXPMLz/73xW2paAwy/5x
 YdKLIX7gIXaSRDwfGy0HGOUKLo2WPHwkwHl50e8oTeXPMAYXCZyDrmqkrCyA7Y9ASTw==
X-Gm-Gg: AR+sD10n4aAaSMVSz0iSYjNFBa8cXTOTdLSUhcrnSXZtaUwUBFG34Q46MlZTJasTbSU
 p7onHIJ+BuowyrZZ+2KmYSIE7oZHOHLl0vJfOoU35x+mOORXJitLFVAqnWv8oILn3gn0wyIVDS8
 YN5xZGBgZ9/5MbqAxFPeGfdV3uM0M2UKIZtsC7sDvJfgSnmIUOU8cgv0WapoyyeAwIGQPrxoHXM
 QU99KZCtzCUkXizNjFEj+GrJX1dhygXK9qjkstfleQTagClxGbEoFlBpba3Lejp49hwMl8IJLZs
 kiTxjDxkJJA3ZcoAd5oCn1p5CA+5s9lQXmo+eBWKkZMgBw4f8RTqj6NuUdedf4LJG98ighAiYnb
 CVwA5U5q9uzBEpNvDVtiIIjMPPzsK2fPwRG+r4SkNIVFzfPEe
X-Received: by 2002:a05:6a21:33a0:b0:3bf:6237:4d3f with SMTP id
 adf61e73a8af0-3cd012c84a2mr2125756637.18.1787103114992; 
 Tue, 18 Aug 2026 18:31:54 -0700 (PDT)
X-Received: by 2002:a05:6a21:33a0:b0:3bf:6237:4d3f with SMTP id
 adf61e73a8af0-3cd012c84a2mr2125672637.18.1787103114523; 
 Tue, 18 Aug 2026 18:31:54 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327befa4b94sm1157539eec.13.2026.08.18.18.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 18:31:53 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 05/11] target/hexagon: take BQL when reading the system pcycle
 count
Date: Tue, 18 Aug 2026 18:31:38 -0700
Message-Id: <20260819013144.3264096-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
References: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAwOSBTYWx0ZWRfXzjR3Abz7grHm
 VAGzEJkiTJ/x+aflfWNNtMrtKWqt7FYIhu2Rfnf+rgHFOwsZwnZUwTWBmzM9H4f4p/Jb9UgRkew
 T45EnE7yw2QNEd2t4hbsuZcjR+r2wrc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAwOSBTYWx0ZWRfXwo8SWSl3PDO8
 jfLF5nghCCtaJ49pgbf8lhLyZNZNMOS7fb2+mjo5ckcj0Mbv0sBdhrzyexS5jw+Kq7OsaEw3MYc
 BgrjyA5UHYsvBaIzF7wwbDZlRidAgvUDxuenjwcgt0EON2YJNVWDbXZ02sOO5BjCVuAz6g09KiE
 T0opMb9SJhLV0N+yUC0vrk8IcsEz5KSP3364sYk8Lz72b4yiMJvwDSKxdOqQSywE5zL4K+HshEq
 S83T9Zr9fqfDqtM2dz7eUVHe6X//HFQtl0AaflDmukhsZRmlmklI0y3BZs5zmvl+VNgoicnD1be
 gmuTz0kZ5Qn5qSJpxGrdIhoVzm3Osu+B6PTipyKervQA5cRj78u06XT3xeyMHz63/eHS87PX9fI
 t99Z5HLjLi+ciAag1nAu90tLykpM6BqKd198DzwIUVGavBFnzuF2Rm0eBqK56PLzcNAvJva29Ox
 vGNZVF2IyyAjBR1Ia7w==
X-Proofpoint-ORIG-GUID: BbGJYRDgvdJ-TvxOUKgCAmcB2Svgg2bg
X-Authority-Analysis: v=2.4 cv=bN0m5v+Z c=1 sm=1 tr=0 ts=6a85078b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=tKA3sQWDS_42iA0j-SoA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: BbGJYRDgvdJ-TvxOUKgCAmcB2Svgg2bg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_05,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190009
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

aGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3VudCgpIGl0ZXJhdGVzIGFsbCBDUFVzLCBzbyB0YWtl
IHRoZSBCUUwgd2l0aApCUUxfTE9DS19HVUFSRCgpIGluc3RlYWQgb2YgYXNzZXJ0aW5nIHRoZSBj
YWxsZXIgYWxyZWFkeSBob2xkcyBpdC4KQ29udmVydCB0aGUgbWF0Y2hpbmcgc2V0dGVycyB0aGUg
c2FtZSB3YXksIHdoaWNoIGtlZXBzIHRoZSBsb2NraW5nCmNvbnRyYWN0IHN5bW1ldHJpYyBhbmQg
bWFrZXMgdGhlIHJlYWQtbW9kaWZ5LXdyaXRlIGluIHRoZSBfbG93L19oaWdoCnNldHRlcnMgYXRv
bWljLiAgQlFMX0xPQ0tfR1VBUkQoKSBpcyBhIG5vLW9wIHdoZW4gdGhlIGxvY2sgaXMgYWxyZWFk
eQpoZWxkLCBzbyB0aGUgbmVzdGVkIGd1YXJkcyBvbiB0aGUgZ3Vlc3QtcmVnaXN0ZXIgcmVhZCBw
YXRoIGNvc3Qgbm90aGluZy4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5A
b3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHVfaGVscGVyLmMgfCAxMiAr
KysrKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIGIvdGFyZ2V0L2hl
eGFnb24vY3B1X2hlbHBlci5jCmluZGV4IDY0YzU3NDZjNmQ5Li42NDljNTgzYzBmYSAxMDA2NDQK
LS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2Nw
dV9oZWxwZXIuYwpAQCAtMzYsNyArMzYsNyBAQCB1aW50NjRfdCBoZXhhZ29uX2dldF9zeXNfcGN5
Y2xlX2NvdW50KENQVUhleGFnb25TdGF0ZSAqZW52KQogICAgIHVpbnQ2NF90IHRvdGFsID0gMDsK
ICAgICBDUFVTdGF0ZSAqY3M7CiAKLSAgICBnX2Fzc2VydChicWxfbG9ja2VkKCkpOworICAgIEJR
TF9MT0NLX0dVQVJEKCk7CiAgICAgQ1BVX0ZPUkVBQ0goY3MpIHsKICAgICAgICAgQ1BVSGV4YWdv
blN0YXRlICp0aHJlYWRfZW52ID0gY3B1X2Vudihjcyk7CiAgICAgICAgIHRvdGFsICs9IHRocmVh
ZF9lbnYtPnRfY3ljbGVfY291bnQ7CkBAIC01NCwxMSArNTQsMTUgQEAgdWludDMyX3QgaGV4YWdv
bl9nZXRfc3lzX3BjeWNsZV9jb3VudF9sb3coQ1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAgcmV0
dXJuICh1aW50MzJfdCkoaGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3VudChlbnYpKTsKIH0KIAor
LyoKKyAqIEV2ZXJ5IGZ1bmN0aW9uIGluIHRoaXMgZmFtaWx5IHRha2VzIHRoZSBCUUwgaXRzZWxm
LCBzbyB0aGUgZ3VhcmQgYmVsb3cKKyAqIGhvbGRzIGl0IGFjcm9zcyB0aGUgcmVhZC1tb2RpZnkt
d3JpdGUuICBOZXN0ZWQgZ3VhcmRzIGFyZSBuby1vcHMuCisgKi8KIHZvaWQgaGV4YWdvbl9zZXRf
c3lzX3BjeWNsZV9jb3VudF9oaWdoKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCB2YWwp
CiB7CiAgICAgdWludDY0X3Qgb2xkOwogCi0gICAgZ19hc3NlcnQoYnFsX2xvY2tlZCgpKTsKKyAg
ICBCUUxfTE9DS19HVUFSRCgpOwogICAgIG9sZCA9IGhleGFnb25fZ2V0X3N5c19wY3ljbGVfY291
bnQoZW52KTsKICAgICBvbGQgPSBkZXBvc2l0NjQob2xkLCAzMiwgMzIsIHZhbCk7CiAgICAgaGV4
YWdvbl9zZXRfc3lzX3BjeWNsZV9jb3VudChlbnYsIG9sZCk7CkBAIC02OCw3ICs3Miw3IEBAIHZv
aWQgaGV4YWdvbl9zZXRfc3lzX3BjeWNsZV9jb3VudF9sb3coQ1BVSGV4YWdvblN0YXRlICplbnYs
IHVpbnQzMl90IHZhbCkKIHsKICAgICB1aW50NjRfdCBvbGQ7CiAKLSAgICBnX2Fzc2VydChicWxf
bG9ja2VkKCkpOworICAgIEJRTF9MT0NLX0dVQVJEKCk7CiAgICAgb2xkID0gaGV4YWdvbl9nZXRf
c3lzX3BjeWNsZV9jb3VudChlbnYpOwogICAgIG9sZCA9IGRlcG9zaXQ2NChvbGQsIDAsIDMyLCB2
YWwpOwogICAgIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnQoZW52LCBvbGQpOwpAQCAtODEs
NyArODUsNyBAQCB2b2lkIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnQoQ1BVSGV4YWdvblN0
YXRlICplbnYsIHVpbnQ2NF90IHZhbCkKICAgICBpbnQgbnVtX3RocmVhZHM7CiAgICAgaW50NjRf
dCBkZWx0YSwgcGVyX3RocmVhZCwgcmVtYWluZGVyOwogCi0gICAgZ19hc3NlcnQoYnFsX2xvY2tl
ZCgpKTsKKyAgICBCUUxfTE9DS19HVUFSRCgpOwogICAgIHRvdGFsID0gaGV4YWdvbl9nZXRfc3lz
X3BjeWNsZV9jb3VudChlbnYpOwogCiAgICAgLyogQ291bnQgYWN0aXZlIHRocmVhZHMgKi8KLS0g
CjIuMzQuMQoK

