Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF4CCA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG7V2-00031d-QP; Mon, 12 Oct 2026 00:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7UT-0001zp-Dn
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:18:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7UP-0001C1-EM
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:18:20 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C1lO1J2015728
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N2kRVLUPz/xncyWY8NNP8Z4XmS+dEunUxoTRW7LvuPA=; b=Vsf0T37KTO+DDAMX
 NppOSwllxtDSQRvjUZkBWsTr9AQEM6NsEybw5NoIJkbFU6+iJ99Vzm6g3cPViiMO
 BDCYSq+QLRyUEim/Z6YgKxyKg84Z/Ek7FKZ5unKJT8nqBZC3r7WTSmp8+htdtHDq
 5ogvm9mFAulhK2gR6fYf8Ep4CAKYdhFeFj4PzoiE/Vjzk+yceMpH5LjHeRzfN5pb
 qY25AJKiNdfmNmNpvUJEIQhbewVB5qEXPfibY7e2rGiBm5v7OmjaoGDQmYJg8+Q/
 1dTxv4t8He3NN0RyWwnZA2+ujd/JCIqT6rxK6JwiKoQx1XpugaqtC0n0iDyJkHxe
 sybwDA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7b2fd0n4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:18:05 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso3981707eec.1
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 21:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791778684; x=1792383484; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N2kRVLUPz/xncyWY8NNP8Z4XmS+dEunUxoTRW7LvuPA=;
 b=Z6RoD5pbmO11nKaLqMtz05xG16yhEaMko8M/EBw9vdMojoji/rNDkfbYRlqGkuxqb5
 hcmvnRMpD3dx2/oOfa0uLKofe1ll9wAJuFeYklcNQC7RpRcA7okWDdTJUUEk5fliXhXr
 K0A1q/Q7teejo3aUrd3HoGUwLvujiGvC1cj3G4LOkr3TPDlfFrJCjvfieBTse/c85Zeh
 B0/ToqsAL80q5w9UPw0FPgDakAY4taw0WOP8wXwBdGC1ollG0WXgcWzlfH2uYKGpguBr
 M4KcG2m24BmTC3XgccrZ8gbxDwheg3nT5ujQx/TfYzW2JWdK+eM3VSsngX9rl127b9td
 qlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791778684; x=1792383484;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N2kRVLUPz/xncyWY8NNP8Z4XmS+dEunUxoTRW7LvuPA=;
 b=ahD4neGymYQ90OkAjqHP9Y8FidkaUOcLvqZAeVB88b/Uutxh4iiSZvKlNn9DVIsyuf
 n7sRWkfNYUPg4Q7ESm51HU3IbftiNTN+wnOcu5tMHvoeAyo5Ty0FJ4bkzGfpLn4pv2zN
 nOU+9Uz2dBbDi3LX98KNRdD2p1FSl5eg3aqgY0TzuVCkszsh08ctDeuDZb1aeUoBz+iD
 G0AKyIRPUJQ3Qvh7UMayAvewTymvp7guOCo8H24QvaA/kcd6UvCVMB80b4nKFBfISAZM
 3tTIkwIMYgG16vxbNgn7O/ykR5BZPORIGGoKm4XrpPeGElTgE4gsD5oqFqlixKQ8TBm4
 ZmkQ==
X-Gm-Message-State: AFq9FYKTm70xW+uS9eDrvAQ2GsIAdwI5qFnnTm6O0V/DdjhzZLUkgxbt
 uoXUP00ta2VK3cc+xJMY2ool+ViuwzdZ13FD7DtNst3hHyjTfMEZUbtXK0TklaU0TXWZMQj1eqk
 EaXSlRqQRb2tQONVZDSz9OD5BbEXz0zKxx+tDMstGgrSfmX55rF2Ao2A5CnnGANeWoA==
X-Gm-Gg: AYBFou034LZx8IhVfsoeBlX81v7WFsgI5dbfP0nABCdSXQ+Lz8wecCLz7abGPpXOgh+
 A3+D5yfV41b44ctlretncSDmC32OJbuck1I/ty/Bad+vPFMooDbLg4fo2UlBdk542ndax0Ku9ju
 FDYBoH11Ih1X2VW7BrOk/Mr02i+jUAYaDnRS/gjRH3SduJwdRQQBRpMTaLWUOFykngLihv7T2XL
 GYyn9/fbMzbChI8IgXaMeTTjizzQo0eVS24QcJK3cPdJC4LT4nkrDYdC9gJIBBEFaOjAmtrAD7g
 JVmft96PDr9JXnO6viRoeEEbE1vhB9nVQsyihLnRQVPxYsK3YlA6TvLRKcZERQlilc2dBJvnO+2
 hapkaRIp4QXlkQIxSBx1UJ23Hzkf8ndQ6Ltwz63UbYO15yEE=
X-Received: by 2002:a05:693c:4196:20b0:35b:af:a075 with SMTP id
 5a478bee46e88-35b00afb749mr1355672eec.22.1791778684303; 
 Sun, 11 Oct 2026 21:18:04 -0700 (PDT)
X-Received: by 2002:a05:693c:4196:20b0:35b:af:a075 with SMTP id
 5a478bee46e88-35b00afb749mr1355635eec.22.1791778683669; 
 Sun, 11 Oct 2026 21:18:03 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841648sm32369096eec.3.2026.10.11.21.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 21:18:02 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 22/25] target/hexagon: publish TLB updates before flushing
Date: Sun, 11 Oct 2026 21:17:19 -0700
Message-Id: <20261012041722.1159355-23-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
References: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfX3MDRa+Zfa9xl
 Bh/hoYwJAD8aI2QDWvf1VxcJ5vEczi5dII4U/6sA6JH4NnHAbsTYX9RumBpRUGHLNjrX5YLYfOk
 O+pbA/HI6lmF/XDtz9MPnbxMy2qJ3n8=
X-Proofpoint-GUID: B1Hg14ScB1wqI5p458tc4PYRJxGP8lo4
X-Authority-Analysis: v=2.4 cv=NddzRGD4 c=1 sm=1 tr=0 ts=6acc5f7d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=0EjuWJ-_TiHYVK0t5P0A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfXwWhb8Iaxo0EG
 0uZbaosct0ZhXKFgnv+YVSHRcjbv/yzF+7Zwj+8GUZCWgeFKe9JvHXdAawihCQTmqg0gvkZq0+l
 4oKzab91JAkdnI8S0mF2u8Vn4QMAJB07mikYaBEbfZsh7hLbaFunNR+uLnYif5oQKIH51/GKJUI
 n09AtpUrn3mCNUrtLPd2wjtfF+mBCz5/gtpv4OK/9oXQRR1kiuQTb4SqYmjFujJqY8PM24s7qwT
 YEvQHP59zs9LgMt+9g0sMUqG+5TrCh5u/Fv2XOnbVfPnTFHLh5GvimDpt07CpweJqjx2tBuD+Od
 Qc5n6uyvpSPgnrMJe/BWupv+u6O9rNcm90hHotbwTEXNmSXdiAuysCO0qEVAlFwKao/1m8KyTBy
 yf/8x05LLtS+H97GWUEJsrVghkpu+ksm3Bcjz8Tg/sDuGR57DTVqXytqGhkpCiPcAS67bSXI7MO
 r+J4JUYrQ7FqkiGDCEg==
X-Proofpoint-ORIG-GUID: B1Hg14ScB1wqI5p458tc4PYRJxGP8lo4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120016
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

UmVwbGFjZSB0aGUgc2hhcmVkIGFyY2hpdGVjdHVyYWwgZW50cnkgZmlyc3QsIHJlbGVhc2UgaXRz
IGxvY2ssIGFuZApvbmx5IHRoZW4gY2FsbCB0bGJfZmx1c2hfYWxsX2NwdXNfc3luY2VkKCkgd2hl
biBhIHZhbGlkIG1hcHBpbmcgd2FzCnJlcGxhY2VkLgoKVGhlIG9sZCBvcmRlcmluZyBmbHVzaGVk
IHJlbW90ZSBzb2Z0IFRMQnMgYmVmb3JlIHB1Ymxpc2hpbmcgdGhlCnJlcGxhY2VtZW50LCBhbGxv
d2luZyBhIHJlc3VtZWQgdkNQVSB0byByZWZpbGwgdGhlIHN0YWxlIG1hcHBpbmcuCgpSZXZpZXdl
ZC1ieTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVk
LW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRh
cmdldC9oZXhhZ29uL2hleF9tbXUuYyB8IDYgKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hl
eF9tbXUuYyBiL3RhcmdldC9oZXhhZ29uL2hleF9tbXUuYwppbmRleCA3ZDVmYjk4N2UxOC4uMGNh
NTJlZDY2NmQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9tbXUuYworKysgYi90YXJn
ZXQvaGV4YWdvbi9oZXhfbW11LmMKQEAgLTMxLDE0ICszMSwxMiBAQCB2b2lkIGhleF90bGJ3KENQ
VUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBpbmRleCwgdWludDY0X3QgdmFsdWUpCiB7CiAg
ICAgdWludDMyX3QgbXlpZHggPSBmVExCX05PTlBPVzJXUkFQKGZUTEJfSURYTUFTSyhpbmRleCkp
OwogICAgIEhleGFnb25UTEJTdGF0ZSAqdGxiID0gZW52X2FyY2hjcHUoZW52KS0+dGxiOwotICAg
IHVpbnQ2NF90IG9sZF9lbnRyeSA9IGhleGFnb25fdGxiX3JlYWQodGxiLCBteWlkeCk7Ci0KKyAg
ICB1aW50NjRfdCBvbGRfZW50cnkgPSBoZXhhZ29uX3RsYl93cml0ZSh0bGIsIG15aWR4LCB2YWx1
ZSk7CiAgICAgYm9vbCBvbGRfZW50cnlfdmFsaWQgPSBleHRyYWN0NjQob2xkX2VudHJ5LCA2Mywg
MSk7CiAgICAgaWYgKG9sZF9lbnRyeV92YWxpZCAmJiBoZXhhZ29uX2NwdV9tbXVfZW5hYmxlZChl
bnYpKSB7CiAgICAgICAgIENQVVN0YXRlICpjcyA9IGVudl9jcHUoZW52KTsKLSAgICAgICAgdGxi
X2ZsdXNoKGNzKTsKKyAgICAgICAgdGxiX2ZsdXNoX2FsbF9jcHVzX3N5bmNlZChjcyk7CiAgICAg
fQotICAgIGhleGFnb25fdGxiX3dyaXRlKHRsYiwgbXlpZHgsIHZhbHVlKTsKICAgICBoZXhfbG9n
X3RsYncobXlpZHgsIHZhbHVlKTsKIH0KIAotLSAKMi4zNC4xCgo=

