Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA5F606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nYhuBSHW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P9vzomQL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQUR5-0003xE-8Z; Mon, 09 Nov 2026 13:49:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQUQx-0003wI-LG
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 13:49:39 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQUQv-0005I8-PN
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 13:49:35 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HH79b879260
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 18:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8XyDR9YAbCVUIH71fLGKb8tlA0BJpq2yPdnsJPtwhW4=; b=nYhuBSHWR99+lrNk
 y2gZyO9jG9Texb+gRivS0M8nivobZlT9UTFa0P9pqfLILoGgnrbtMEvm6UsIyJgc
 f6p0jzxrx+DdUw7xTFHU57Yu5VOEsWgDWRBRkSVvKGOP31rUV3q1zg/81NAGNcmu
 CxNXhtE+P5i2RgPXMEou5TjHPA7eHgdPEpjwzEb9amSFmmc4UoiN3batCxHqfaFV
 sr9Qtou1m/BlHUiFXF2MpIM/AY3Ht4FluG8RF/R3aRcnkSKqIA060/FDaliX5w/K
 PjHu/oyDPdwV/uSCRnn2XCqLx7dfzno5OTX2a0DYDhSAA+gsaNhwo1qCABKpbcYe
 chZOqA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucr5spu2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 18:49:32 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-37390b2989bso1849356eec.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 10:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794250172; x=1794854972; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8XyDR9YAbCVUIH71fLGKb8tlA0BJpq2yPdnsJPtwhW4=;
 b=P9vzomQLwUwSCwBsIyheVl8ELDdpnAPFPiHCTGAH89RugwMTs+dMBmOTS/ReN0gyEm
 tvHtrwudt3HIvNxQ7/33xz8sBgAnaDuZWuW9RI3hFuoM2SCxOP8EqIyYi+HNhkH88xKf
 6DHLXodbJoTf+sx6dE6rhTrTBni6cXtRpHoIuGjremK8j8isTQwm8vdKFcRBCVm8YlRM
 aSrVJGZL9FC9pCQKVcYVZdxMZfHRO+OCHipIXk/f65h8EAtLEpLA+d/X4k40auTGeBVO
 BPzSjm6KVSDr+ivF4JQA88O9ILDmXdfzNMBOngPGLNigR3B+qUQgpd5radD/441CJOjR
 ovqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794250172; x=1794854972;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8XyDR9YAbCVUIH71fLGKb8tlA0BJpq2yPdnsJPtwhW4=;
 b=21ctrSqNM8REd6XpQkzMz+HosXLNVhm8xxxkMF1gEUi5bBcdhI9GQV2ZlIEICbb1CW
 f9UQmzDAUK/whwxfOKttgbmOutEpXzyogFeAyixvJgnoUfM0sdO4QT7XpeKgbmjrvLPq
 4xZ5tlz7Ed9kjOMGln2o7vIw9VMxanAx2B5g8kFZwrqbiqRUv6/mQudOSSPCI61sWfD0
 PrCj1UCuzKvPoj9XmShC6rJCKPwz/ugWtpjLK/Dz4UM4O1H5H1fj/Ys2eWwSZASZ8igC
 34+4iglqEPceQ3TkESFd13BA82x2bIP7PCiEP+fCTuRdqIMFPkMx0EojAmIyjiUPKesQ
 6x4w==
X-Gm-Message-State: APuU4Z9q66kt5MoQ7oYeXTbGkI/D7+0mk8BcTp4UU7Ng6yXHE8EzDyzY
 ODh8dI7PuEkJlRn0ybR7C0l5Xhj/tn9qjsKY1gG2RRDV+M+vygDrMqVH3ZEzIjpoUCpy3d2JMoF
 UM2bkvYUNpyudlq8F89m5XKQhDwW8XUY8tdl8p70dBg5ss0yPkl60MzhE9go6Zwiy6A==
X-Gm-Gg: AYBFou2gyXaXoFsKLjh/LAMUjsesRnKyNjUtkkN3IsumPsto4bGONmUg1DduKjJltDX
 kX0nV1SR+gioAMCAN6peqEqG1W4j/Y6vaeseE+dQ52X5nFd3Su3MtoI0n9pW2EAR7t5jXIcZ4LQ
 Bz8yYv3wfdoiTyZbCrpENowzxmBxdPAT7XyvH2xJSL6txM7SHFwvblFri2SAveQBm28ZmJA0GZD
 mEd5wQ/ZzlcJnAlGnoJSBeAm1H+BB3CJymbETTuCHnBk27JGAvjDCxOaG2wnApflscbhEK+Yxtw
 lUItyvOSbqWcB8/S52A1eQ3tzX8DicDau7T5HvbBhImDRBCJFhuaz0/I9UFW0aRl/A6CPKD7zd4
 9q5BF1lmEnq3b7IABrA2P2I39VaBGeqb/EMBA/r1rwAygpWZ69HFFXhdlOjlx/BPfT7CFnaAIHb
 mWwczs1gsqSGtD8hUdqqn7
X-Received: by 2002:a05:693c:6407:b0:36f:65b6:d137 with SMTP id
 5a478bee46e88-3751f45ff37mr156941eec.24.1794250171693; 
 Mon, 09 Nov 2026 10:49:31 -0800 (PST)
X-Received: by 2002:a05:693c:6407:b0:36f:65b6:d137 with SMTP id
 5a478bee46e88-3751f45ff37mr156899eec.24.1794250171092; 
 Mon, 09 Nov 2026 10:49:31 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3751fe306e3sm239797eec.7.2026.11.09.10.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 10:49:30 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v2 3/3] hw/hexagon: fix FDT address and size cells
Date: Mon,  9 Nov 2026 10:49:24 -0800
Message-Id: <20261109184924.4149076-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109184924.4149076-1-brian.cain@oss.qualcomm.com>
References: <20261109184924.4149076-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3NCBTYWx0ZWRfX7V0ZARCUg37+
 svW2eZujvMG9MA2+qq1JYi/h7aG/nYH3vf6djzj+ZxF2261OCFSHLF8awtsDMn6vPvBD8nlMUxd
 fnSGyQjpCaYsNGlaPVNpnXnOSy+L+a8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3NCBTYWx0ZWRfXwU65uZZEUMY/
 3aebRdRGHqOX3FCFEqY5vBPGIrYm1cKepIJkqJRyOmANH8VsV/hiBTMKlEiQz82392BIS3ITIqE
 IFBny8uvsNolnOeIu4LyMo+q687O87CLIyWFArr8xU3svVU3/TrYInivoDSoIxBseyp3Y0l8+DL
 gjIk6faZ+8d/qpS5FZbfS275wdb9pumGkU/j+7bU+4qiH2WaByiw7zRkh+UCgO+zV7K6UMw0Qzb
 pMiKiY+MnkdZlmnP7IhlAL8z2tuSOuGHnPqLu7W1wmar1Dub9XU6bbANdtELVP8nRdCS+Ura7Em
 B0g/VUOZtuTJ9rISlqrZSv/upAVEAjDmlgqKSULTv1IIlzHuWMK/ThE5cpnz77242XJnyw8h/oF
 Q2NX+oXz7qGLrJjTKj0yMjZt4dMBIRyVfzLfNGB3zy1zcJ09xm6QTTfsw6YJ+exz6/h+iqdLSRz
 3OVGeg17TYuqWoXrrFA==
X-Authority-Analysis: v=2.4 cv=ErlHPicA c=1 sm=1 tr=0 ts=6af215bc cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=3RaGgONpw-BU2ZlCsxAA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: lhjSkd0aFbEkUEKctxWRd9R0fpdXlZrJ
X-Proofpoint-GUID: lhjSkd0aFbEkUEKctxWRd9R0fpdXlZrJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090074
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGV4YWdvbiBNTVVzIHN1cHBvcnQgNjQtYml0IHBoeXNpY2FsIGFkZHJlc3Nlcy4gIERlc2NyaWJl
IHRoZSByb290IGFuZAovc29jIGJ1c2VzIHdpdGggdHdvIGFkZHJlc3MgY2VsbHMgYW5kIHR3byBz
aXplIGNlbGxzIHNvIHRoZWlyIGNoaWxkIHJlZwpwcm9wZXJ0aWVzIGNhbiByZXByZXNlbnQgdGhl
IGZ1bGwgYWRkcmVzcyBhbmQgc2l6ZSByYW5nZS4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJy
aWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBody9oZXhhZ29uL2hl
eC1ib2FyZC5jIHwgMTMgKysrKysrKy0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ody9oZXhhZ29uL2hleC1ib2FyZC5j
IGIvaHcvaGV4YWdvbi9oZXgtYm9hcmQuYwppbmRleCBkMmU5NThmOWI1NS4uODRmNGVmOWY4ZDIg
MTAwNjQ0Ci0tLSBhL2h3L2hleGFnb24vaGV4LWJvYXJkLmMKKysrIGIvaHcvaGV4YWdvbi9oZXgt
Ym9hcmQuYwpAQCAtNDMsMTMgKzQzLDEzIEBAIHZvaWQgaGV4X2JvYXJkX2NyZWF0ZV9mZHQoTWFj
aGluZVN0YXRlICptcywgY29uc3QgY2hhciAqbW9kZWwsCiAgICAgbXMtPmZkdCA9IGZkdDsKIAog
ICAgIHFlbXVfZmR0X3NldHByb3BfY2VsbChmZHQsICIvIiwgIiNhZGRyZXNzLWNlbGxzIiwgMHgy
KTsKLSAgICBxZW11X2ZkdF9zZXRwcm9wX2NlbGwoZmR0LCAiLyIsICIjc2l6ZS1jZWxscyIsIDB4
MSk7CisgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxsKGZkdCwgIi8iLCAiI3NpemUtY2VsbHMiLCAw
eDIpOwogICAgIHFlbXVfZmR0X3NldHByb3Bfc3RyaW5nKGZkdCwgIi8iLCAibW9kZWwiLCBtb2Rl
bCk7CiAgICAgcWVtdV9mZHRfc2V0cHJvcF9zdHJpbmcoZmR0LCAiLyIsICJjb21wYXRpYmxlIiwg
Y29tcGF0aWJsZSk7CiAKICAgICBxZW11X2ZkdF9hZGRfc3Vibm9kZShmZHQsICIvc29jIik7CiAg
ICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxsKGZkdCwgIi9zb2MiLCAiI2FkZHJlc3MtY2VsbHMiLCAw
eDIpOwotICAgIHFlbXVfZmR0X3NldHByb3BfY2VsbChmZHQsICIvc29jIiwgIiNzaXplLWNlbGxz
IiwgMHgxKTsKKyAgICBxZW11X2ZkdF9zZXRwcm9wX2NlbGwoZmR0LCAiL3NvYyIsICIjc2l6ZS1j
ZWxscyIsIDB4Mik7CiAgICAgcWVtdV9mZHRfc2V0cHJvcChmZHQsICIvc29jIiwgInJhbmdlcyIs
IE5VTEwsIDApOwogCiAgICAgcWVtdV9mZHRfYWRkX3N1Ym5vZGUoZmR0LCAiL2Nob3NlbiIpOwpA
QCAtNzgsNyArNzgsNyBAQCBpbnQzMl90IGhleF9ib2FyZF9mZHRfYWRkX2wydmljKE1hY2hpbmVT
dGF0ZSAqbXMsCiAgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxsKG1zLT5mZHQsIG5vZGVuYW1lLCAi
I2ludGVycnVwdC1jZWxscyIsIDIpOwogICAgIHFlbXVfZmR0X3NldHByb3AobXMtPmZkdCwgbm9k
ZW5hbWUsICJjb21wYXRpYmxlIiwgY29tcGF0LCBzaXplb2YoY29tcGF0KSk7CiAgICAgcWVtdV9m
ZHRfc2V0cHJvcF9jZWxscyhtcy0+ZmR0LCBub2RlbmFtZSwgInJlZyIsIDAsIGNmZy0+bDJ2aWNf
YmFzZSwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgIGNmZy0+bDJ2aWNfc2l6ZSk7CisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAwLCBjZmctPmwydmljX3NpemUpOwogICAgIHFlbXVfZmR0
X3NldHByb3AobXMtPmZkdCwgbm9kZW5hbWUsICJpbnRlcnJ1cHQtY29udHJvbGxlciIsIE5VTEws
IDApOwogICAgIHFlbXVfZmR0X3NldHByb3BfY2VsbChtcy0+ZmR0LCBub2RlbmFtZSwgInBoYW5k
bGUiLCBsMnZpY19waGFuZGxlKTsKIApAQCAtOTUsNyArOTUsOCBAQCB2b2lkIGhleF9ib2FyZF9m
ZHRfYWRkX2h2eChNYWNoaW5lU3RhdGUgKm1zLAogICAgICAgICBxZW11X2ZkdF9zZXRwcm9wX3N0
cmluZyhtcy0+ZmR0LCAiL3NvYy92dGNtIiwgImNvbXBhdGlibGUiLAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAicWNvbSxoZXhhZ29uX3Z0Y20iKTsKICAgICAgICAgcWVtdV9mZHRf
c2V0cHJvcF9jZWxscyhtcy0+ZmR0LCAiL3NvYy92dGNtIiwgInJlZyIsIDAsCi0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdC0+dnRjbV9iYXNlIDw8IDE2LCB0LT52dGNtX3NpemVfa2Ig
KiAxMDI0KTsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0LT52dGNtX2Jhc2UgPDwg
MTYsIDAsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdC0+dnRjbV9zaXplX2tiICog
MTAyNCk7CiAgICAgfQogCiAgICAgaWYgKHQtPmV4dF9jb250ZXh0cyA+IDApIHsKQEAgLTE3NSw3
ICsxNzYsNyBAQCB2b2lkIGhleF9ib2FyZF9jcmVhdGVfdWFydChNYWNoaW5lU3RhdGUgKm1zLCBo
d2FkZHIgYmFzZSwgaHdhZGRyIHNpemUsCiAgICAgcWVtdV9mZHRfYWRkX3N1Ym5vZGUobXMtPmZk
dCwgbm9kZW5hbWUpOwogICAgIC8qIENhbid0IHVzZSBzZXRwcm9wX3N0cmluZyBiZWNhdXNlIG9m
IHRoZSBlbWJlZGRlZCBOVUwgKi8KICAgICBxZW11X2ZkdF9zZXRwcm9wKG1zLT5mZHQsIG5vZGVu
YW1lLCAiY29tcGF0aWJsZSIsIGNvbXBhdCwgc2l6ZW9mKGNvbXBhdCkpOwotICAgIHFlbXVfZmR0
X3NldHByb3BfY2VsbHMobXMtPmZkdCwgbm9kZW5hbWUsICJyZWciLCAwLCBiYXNlLCBzaXplKTsK
KyAgICBxZW11X2ZkdF9zZXRwcm9wX2NlbGxzKG1zLT5mZHQsIG5vZGVuYW1lLCAicmVnIiwgMCwg
YmFzZSwgMCwgc2l6ZSk7CiAgICAgZmR0X3NldF9pcnEobXMsIG5vZGVuYW1lLCBpcnEpOwogICAg
IHFlbXVfZmR0X3NldHByb3BfY2VsbChtcy0+ZmR0LCBub2RlbmFtZSwgImludGVycnVwdC1wYXJl
bnQiLAogICAgICAgICAgICAgICAgICAgICAgICAgICBsMnZpY19waGFuZGxlKTsKQEAgLTIxMSw3
ICsyMTIsNyBAQCB2b2lkIGhleF9ib2FyZF9jcmVhdGVfdmlydGlvKE1hY2hpbmVTdGF0ZSAqbXMs
IGh3YWRkciBiYXNlLCBod2FkZHIgc2l6ZSwKICAgICAgICAgcWVtdV9mZHRfYWRkX3N1Ym5vZGUo
bXMtPmZkdCwgbm9kZW5hbWUpOwogICAgICAgICBxZW11X2ZkdF9zZXRwcm9wX3N0cmluZyhtcy0+
ZmR0LCBub2RlbmFtZSwgImNvbXBhdGlibGUiLAogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAidmlydGlvLG1taW8iKTsKLSAgICAgICAgcWVtdV9mZHRfc2V0cHJvcF9jZWxscyhtcy0+
ZmR0LCBub2RlbmFtZSwgInJlZyIsIDAsIHNsb3QsIHNpemUpOworICAgICAgICBxZW11X2ZkdF9z
ZXRwcm9wX2NlbGxzKG1zLT5mZHQsIG5vZGVuYW1lLCAicmVnIiwgMCwgc2xvdCwgMCwgc2l6ZSk7
CiAgICAgICAgIGZkdF9zZXRfaXJxKG1zLCBub2RlbmFtZSwgaXJxKTsKICAgICAgICAgcWVtdV9m
ZHRfc2V0cHJvcF9jZWxsKG1zLT5mZHQsIG5vZGVuYW1lLCAiaW50ZXJydXB0LXBhcmVudCIsCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsMnZpY19waGFuZGxlKTsKLS0gCjIuMzQuMQoK

