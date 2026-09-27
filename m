Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E81C98328
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 02:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAerz-00053u-Dy; Sat, 26 Sep 2026 22:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xAerx-00053W-VS
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 22:44:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xAerw-0007Vy-Fe
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 22:44:01 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QMMSRC893068
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oy6OGQa50MeZomij2hCC8Ym4uBo/pN8V7bfusE6yIXI=; b=lYk76Rb49A5xIleA
 rSrECT30eelUHpS3TEPsRlSAOl0nEqNfT8Vxlk+qC3AWg0hy2+r4I/BixOlyq2jF
 vucwQLbeTxRsJ+fMeCTtwxLeeWRjQ8Ki1nfljx3HLO/o4l/jvelBHSRlUeuSGL0a
 ozMIw9ueyXBuUjcmH6scc5mz4oEf5ZEKvlJm2jsydKHCi0mqn1PfJyYoJ9HwXR8U
 0Fh6xGof2ILEETLrPsfqU2K+EqQvRPteJCCngmkNqbYU6VKpnNkIh4BBnOQyujbC
 OdZ/qxcOxbrOrfog327vFIgEQBj5ukpaoQ2LkDlhpppfpzCZqNu41A5YLQFOUa4H
 kP0hsg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx3dp2f6k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:43:59 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-14383177746so3496899c88.1
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 19:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790477038; x=1791081838; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oy6OGQa50MeZomij2hCC8Ym4uBo/pN8V7bfusE6yIXI=;
 b=PO0+C9n3A/h/dE16oj2zRafiVpg8ZXKZxUYJMECX4oAMXCvspmcMJT16/lXO3/yHOQ
 I/ejrfHjjedwVp3c0/RMazKrWtBSlyhXZdpSTw1mK/SNgkdn0/1OEj7aedSdX48TZxry
 OsTksqm/DdxD0KrqUAm6m3fkBzlcXsZyk7FLwfMC1zkpdW1O5i0xBBXkAo20FmQC/QrN
 M008+8nGME8ugrnkwHQl//10urwzOvlYY/jYkCzePTek//r4cSKxlGikyybKpvjWLaFu
 ZHmQ5de2W2M8Tfv06r3XlHCiTvueBa7U/ym3l99fp0Wj9CWfuT/lX46ShwVaCShoLkRJ
 3Eiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790477038; x=1791081838;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oy6OGQa50MeZomij2hCC8Ym4uBo/pN8V7bfusE6yIXI=;
 b=gdeoVU8RIwEIRLIZBzPFxc5Ptrc2PEG4ynr48lRJz1VPxSAd/0QNcdSxI3o/EbPZep
 4es98ri+R1jT/FzhXk81OaTD/pXuTBMCy5EdavEx+m5SvWViAXrMB1KEO99+tSmRiUmB
 CyxW3Vv9nJyxWkW5bVPYNlyIZT9fsfI5jmlg/Gh+diGSfX607HnxUA/LqPFNNuBvDQ2E
 WQ4/yLAivFRd0TadEWm5PfzBvL80mYqmPiFHrplSSKOvtLdsdN1cwPU9nXXvS2BY7JOn
 ag4bJM8Kgyg+w/bZDA5dqaMa7XJoJYTPnME9cM0dUeavhpUY3kjGNsSrEE/jhtc+CWgt
 6J/A==
X-Gm-Message-State: AFuF++mYHGc47XWc8ZrJ5xqrfGoS9hX8bLvtOBqMm9A/8m436O86pJeg
 4w4NTYC9pQOGrRRfGhcEQpICfjNOn4Pr7chsfhZLU3bpY/y+G4ebpoPm9VZxc764k2yjf4CTmiT
 Xx+f1w9tFbYrCkTNZq1Nhq3tRS0LHMeUMpIDuk9y/WlYHHiQCBTrx6qnxs2Utv9Lk/A==
X-Gm-Gg: AYBFou0jWB7hjW9Z+Cuq5N3k+Ld3lyQrbsP/1pcCmom16SFao/6coGxoQ3tlVDmCpkN
 NKNp97i8rSaSHYFcZT2BuvPQZoyLtfZK9DRJqmZhG+LgnP9eyedge9wYeGudLmv2p+MRYVDsaee
 ZOD8NRriM5HLl/7Ky4OmQPcT8OEYBotsRWEsatU27g3tmtKWke8JAvaD80/sUb34MWXtcSz6o0v
 k3neloTLMKBo7iyOW33aEE0reaAaHj6Pfl+RaYD13N6M85/qFFilIx6ock9cFsuFhmVDAiXMGkD
 vOb6U3hURl8MkSz4RyUav+UZudXtXM2P+IF10Cf7qMfSIlP/o9d9AaC1/ykndrRzAMzCi5E6xdP
 ++ETTsGND9zc8pZLdKtq81cbJml8Lbm29ETQhiaI3IxJw4AI=
X-Received: by 2002:a05:701b:4306:20b0:144:c113:77bc with SMTP id
 a92af1059eb24-146cfbdd1d1mr4711658c88.27.1790477037568; 
 Sat, 26 Sep 2026 19:43:57 -0700 (PDT)
X-Received: by 2002:a05:701b:4306:20b0:144:c113:77bc with SMTP id
 a92af1059eb24-146cfbdd1d1mr4711540c88.27.1790477036088; 
 Sat, 26 Sep 2026 19:43:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145ac67c3f8sm15459747c88.3.2026.09.26.19.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 19:43:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 5/5] tests/tcg/hexagon: cover LL/SC reservation clearing
Date: Sat, 26 Sep 2026 19:43:47 -0700
Message-Id: <20260927024347.3545385-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260927024347.3545385-1-brian.cain@oss.qualcomm.com>
References: <20260927024347.3545385-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDAxMCBTYWx0ZWRfX5Xqd74X+ZjxZ
 JzCqLMAHw9ye+U6cHbn9dzPhv5QZyDV5DdecjEzDWYyktlnrUA+0VlSSbp/84RAZ2EfwLVT2fMY
 ooU8MdI/nRU1Jc1Od/eETvOlCP1bORSkqxUKAzKdfJxGW62nS/yqbGq3A1uy+kaV19T3iDQbvbu
 OmIO2ghr2X7HbeOKKqAc83slVcnYvtPPAc2TI0FLF1Q8EWze5RcqmJD3FJitKuoR1rY1HcTvL+n
 OX3Ztw9GDwJ5StjpRAsaLUBN/GqJwNQrQJIsiFnN/71OuqENQR6vVMzd5GN+6sEGf0osRvS4LT6
 /spTzb9/IUH915gmJh+FnY+hHY6dd9xhhKxTEd7zf/uDQvBskY/0HvO6EYS2wj4w0BZ1HjmdayL
 3tBcT1vw4OC9WQWzOHHxWi8y+FHngNi5WIimePJ8fbmfAX1QSYglswdRmVeXlsfSiLnaGLk8coK
 ybrFxLVPKspn8Xf/5EQ==
X-Authority-Analysis: v=2.4 cv=QsXLTlyd c=1 sm=1 tr=0 ts=6ab882ef cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=OvsSgjh5XwAxDixGgywA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: GMtrLehsHzlcn_6vk83nYkXTZF0NEXAA
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDAxMCBTYWx0ZWRfX0devtGWiigTy
 UQqKimAD3SscqZq6bgjbrtdeYZGHgqQXO1qfDOkA3JuZAPNlK6EmppHqDcDjGxFqJ0evwKLwKwP
 fzrUMMOFSFt6SQA0RAd7b4VxqCIu1rY=
X-Proofpoint-ORIG-GUID: GMtrLehsHzlcn_6vk83nYkXTZF0NEXAA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270010
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

QWRkIGxvYWQtbG9ja2VkIGFuZCBzdG9yZS1jb25kaXRpb25hbCBoZWxwZXJzIGFuZCBjaGVjayB0
aGF0IGEKc3RvcmUtY29uZGl0aW9uYWwgd2l0aCBubyBwcmVjZWRpbmcgbG9hZC1sb2NrZWQgZmFp
bHMsIGFuZCB0aGF0IHJldHVybmluZwpmcm9tIGEgc3lzY2FsbCBkcm9wcyB0aGUgcmVzZXJ2YXRp
b24uCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5j
b20+Ci0tLQogdGVzdHMvdGNnL2hleGFnb24vYXRvbWljcy5jIHwgNDAgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9hdG9taWNzLmMgYi90ZXN0cy90Y2cvaGV4
YWdvbi9hdG9taWNzLmMKaW5kZXggMWMyMTY5YjI4YmQuLjUwMTdjYTAwM2YxIDEwMDY0NAotLS0g
YS90ZXN0cy90Y2cvaGV4YWdvbi9hdG9taWNzLmMKKysrIGIvdGVzdHMvdGNnL2hleGFnb24vYXRv
bWljcy5jCkBAIC0yNyw2ICsyNywzMCBAQCBpbnQgZXJyOwogCiAjaW5jbHVkZSAiaGV4X3Rlc3Qu
aCIKIAorc3RhdGljIGlubGluZSBpbnQzMl90IGxvYWRfbG9ja2VkMzIoaW50MzJfdCAqeCkKK3sK
KyAgICBpbnQzMl90IHZhbHVlOworCisgICAgX19hc21fXyBfX3ZvbGF0aWxlX18oIiVbdmFsdWVd
ID0gbWVtd19sb2NrZWQoJVthZGRyXSkiCisgICAgICAgICAgICAgICAgICAgICAgICAgOiBbdmFs
dWVdICI9ciIodmFsdWUpCisgICAgICAgICAgICAgICAgICAgICAgICAgOiBbYWRkcl0gInIiKHgp
CisgICAgICAgICAgICAgICAgICAgICAgICAgOiAibWVtb3J5Iik7CisgICAgcmV0dXJuIHZhbHVl
OworfQorCitzdGF0aWMgaW5saW5lIGludCBzdG9yZV9jb25kaXRpb25hbDMyKGludDMyX3QgKngs
IGludDMyX3QgdmFsdWUpCit7CisgICAgaW50IHJlc3VsdDsKKworICAgIF9fYXNtX18gX192b2xh
dGlsZV9fKAorICAgICAgICAibWVtd19sb2NrZWQoJVthZGRyXSwgcDApID0gJVt2YWx1ZV1cblx0
IgorICAgICAgICAiJVtyZXN1bHRdID0gcDAiCisgICAgICAgIDogW3Jlc3VsdF0gIj1yIihyZXN1
bHQpCisgICAgICAgIDogW2FkZHJdICJyIih4KSwgW3ZhbHVlXSAiciIodmFsdWUpCisgICAgICAg
IDogInAwIiwgIm1lbW9yeSIpOworICAgIHJldHVybiByZXN1bHQgIT0gMDsKK30KKwogc3RhdGlj
IGlubGluZSBpbnQzMl90IGF0b21pY19pbmMzMihpbnQzMl90ICp4KQogewogICAgIGludDMyX3Qg
b2xkLCBkdW1teTsKQEAgLTg5LDYgKzExMywyMSBAQCBzdGF0aWMgaW5saW5lIGludDY0X3QgYXRv
bWljX2RlYzY0KGludDY0X3QgKngpCiB2b2xhdGlsZSBpbnQzMl90IHRpY2szMiA9IDE7IC8qIFVz
aW5nIHZvbGF0aWxlIGJlY2F1c2Ugd2UgYXJlIHRlc3RpbmcgYXRvbWljcyAqLwogdm9sYXRpbGUg
aW50NjRfdCB0aWNrNjQgPSAxOyAvKiBVc2luZyB2b2xhdGlsZSBiZWNhdXNlIHdlIGFyZSB0ZXN0
aW5nIGF0b21pY3MgKi8KIAorc3RhdGljIHZvaWQgdGVzdF9yZXNlcnZhdGlvbnModm9pZCkKK3sK
KyAgICBpbnQzMl90IHZhbHVlID0gMTsKKworICAgIC8qIEEgc3RvcmUtY29uZGl0aW9uYWwgd2l0
aCBubyBwcmVjZWRpbmcgbG9hZC1sb2NrZWQgbXVzdCBmYWlsLiAqLworICAgIGNoZWNrMzIoc3Rv
cmVfY29uZGl0aW9uYWwzMigmdmFsdWUsIDIpLCAwKTsKKyAgICBjaGVjazMyKHZhbHVlLCAxKTsK
KworICAgIC8qIFJldHVybmluZyBmcm9tIGEgc3lzY2FsbCBkcm9wcyB0aGUgcmVzZXJ2YXRpb24u
ICovCisgICAgY2hlY2szMihsb2FkX2xvY2tlZDMyKCZ2YWx1ZSksIDEpOworICAgIGdldHBpZCgp
OworICAgIGNoZWNrMzIoc3RvcmVfY29uZGl0aW9uYWwzMigmdmFsdWUsIDMpLCAwKTsKKyAgICBj
aGVjazMyKHZhbHVlLCAxKTsKK30KKwogdm9pZCAqdGhyZWFkMV9mdW5jKHZvaWQgKmFyZykKIHsK
ICAgICBmb3IgKGludCBpID0gMDsgaSA8IExPT1BfQ05UOyBpKyspIHsKQEAgLTEyMiw2ICsxNjEs
NyBAQCB2b2lkIHRlc3RfcHRocmVhZCh2b2lkKQogCiBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAq
KmFyZ3YpCiB7CisgICAgdGVzdF9yZXNlcnZhdGlvbnMoKTsKICAgICB0ZXN0X3B0aHJlYWQoKTsK
ICAgICBwdXRzKGVyciA/ICJGQUlMIiA6ICJQQVNTIik7CiAgICAgcmV0dXJuIGVycjsKLS0gCjIu
MzQuMQoK

