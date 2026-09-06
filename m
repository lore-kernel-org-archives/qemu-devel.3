Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEC0C79F99
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 22:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3LJN-0006FC-R0; Sun, 06 Sep 2026 18:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x3LJI-0006EZ-Vr
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 18:26:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x3LJH-0003Zl-4X
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 18:26:00 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 686MPRVs2786949
 for <qemu-devel@nongnu.org>; Sun, 6 Sep 2026 22:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +4uuNQK1zpPkZmAqWCtHTvgbtV1c5bPJMqFIPzcmwcc=; b=n8nc5pSoFg+aIYZw
 5p28Vg03uV9zzbnmaaAEjtEYsAJwyvACw+dvgomqOJ4bRTQJlc0RHmIIQVor6JmV
 t+BiiKfIqlKOltlZSXf93ZChNPZZo66Q5Mrm1YkJjkzxz2wfV3ClLjGm2puarkrX
 FI45HwPXYuyb1ERHWJ9uvOFN8BMFIcZX1qtGxH0OhXZrVbpL4lTx9UJyLcsg+n5E
 nzONSL/F5XQOgNBY3b044PhvGGCHTMt5z/fk5ETZTBYwFR32DG5yHC1IKzyYJYgZ
 lUKU8Su7BJ3u4yji+F4eyydAdlGsaLShWvPROIJEQGwjp0t9F1R4Jm4AkpKHPaC8
 +Ys0xA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggany46ry-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 22:25:56 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c89704da8c7so3581822a12.0
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 15:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788733555; x=1789338355; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+4uuNQK1zpPkZmAqWCtHTvgbtV1c5bPJMqFIPzcmwcc=;
 b=CFi3xKWhY4iBP9w0q3bBeLrr8ryko8ZRzDEwoNz2XBShhAgMQj2WZP8J7hoc71UGaj
 30Wn3NP68PbEBXQGFejpww7O1GfQmeBQWj44ALOAKsHiE4E/V1LF9c/EnrCX46CBPidr
 esixQanz9zrzoKDyeG4mzcGH3wcgCzxMIsw32DoXy1VXoNJiAy17Qlijc1fKlFYAe7wl
 DXBvq1dJLq640u9PJrghKPuBNwc3UPkYORJG5WUL1xTlFKT8VLagghmmkuxMRb/sma4t
 tQX9IOvFtXVAMAA9eFMKqRMcbxIelSnmw5fO4Bk+dbulWzdynAcCF9mJrJ9xUgMm0p68
 PcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788733555; x=1789338355;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+4uuNQK1zpPkZmAqWCtHTvgbtV1c5bPJMqFIPzcmwcc=;
 b=TH66ah5dd15atZzxVmZefwNPfvEx90WmAGoG2n355C1hbUv27MM0rtwHM+wkkhdHLP
 J35UPboZp4vkeRGEDN75IAk9XGT4oEuOBgRLyGnc8ZZ3aUQMJGqARrbY8O1RcuvJPIIn
 4FEkx7LASQFupTfauikNGPYnFMP/BySVFU+uFNAz8QnEE+G2dix7mCF7TSpHscC+Q61L
 PgBldg+yeVe79vlhB0PdfbbJElMeeKu47OvS3jnZpmcauphBrXmikf2+NmqNRyMeMgGq
 f0z8LTVJZkp8w5wiU8stgJIceL6btcvQAKU/H1B+gC+1+dFjeGHodcZ2k6jsjvJ7ZUpZ
 CIjQ==
X-Gm-Message-State: AFuF++mPs7l0ta136oxDrr3qkds3RCnTBlEPLnGzoRZxwxo8EnPCDKRG
 Ag/J4FWCbkMkFr53l+sNjphNJ9tP3ZTv4Hqw/csJfHLC2UDHp7De2VLgB5r97Dqa6uuKZ9/J0uL
 /CK+JyV1ETKHAbSsvZjqeSJu8ODcx8NUI0hj6zmMT8o1FCpTlGWI32AbY+38l+PL7ww==
X-Gm-Gg: AYBFou0JDZ372rhlc3EZSLBURxfvaUk4Bep/5dRSI9aiXYN9R8faVokRSkMbE/PrpAv
 aLa8mrr1GdyfEjcyNPI7dFT6AIjNXqKwxNGQ6fnXdnn9+y6JXB1DrtFl2KuLyNp6VwaOBZywTOV
 gQQuJlWkqbWN+s9KAmC1TcNFLq+ERL8j4SBIjD4/04BB4Kjjfs1QJ1y59xxZIvkPdHA4owRMOEm
 CRKkOLL1g2KzrpenawD0SLrth1i9fIXP5i+1LC/ifu6IEkoa08tK81PXbnK0RBNoNZf4kkdk9SH
 jU1oBmFDNgNKcBmu+2jEfZFXm/WtFKxCeGiQF5y85LTUiuNBmmr03/k4SQZsDgItk6mx2MO+JJ7
 5SrJNwhcHcmyo/b3+OoZZYkEXWJx7Rtjp0dr+QHyP9/z6xaW7
X-Received: by 2002:a05:6a21:748e:b0:3d2:5eb3:596 with SMTP id
 adf61e73a8af0-3da3a043152mr29150357637.16.1788733555396; 
 Sun, 06 Sep 2026 15:25:55 -0700 (PDT)
X-Received: by 2002:a05:6a21:748e:b0:3d2:5eb3:596 with SMTP id
 adf61e73a8af0-3da3a043152mr29150320637.16.1788733554832; 
 Sun, 06 Sep 2026 15:25:54 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339ac24d7esm34936605eec.15.2026.09.06.15.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 15:25:54 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 peter.maydell@linaro.org, Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 1/3] target/hexagon: Fix semihosting OPEN filename handling
Date: Sun,  6 Sep 2026 15:25:49 -0700
Message-Id: <20260906222551.3712954-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260906222551.3712954-1-brian.cain@oss.qualcomm.com>
References: <20260906222551.3712954-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=X45i7mTe c=1 sm=1 tr=0 ts=6a9de874 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=wm7e5FjlxgvFdPWeLvoA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: iEJsC3CeIJtJsOT44yUOVNnzFsj6yFup
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA2MDI1MCBTYWx0ZWRfX+lKEmX3g0evF
 28QJPQWqGDvqPnUNUVK0gyhst9Ix1eveuzN6fHDo1jI37AgggKUUuatnskI/mwC7apW4jJ85IeQ
 GiNRXybGLJ3Mwzoy2rCt2zNy6njoRPPNYXsILIE+raEhT+h8fnqtQYYtNNFmPhyko5lWJ6CXaok
 EWYr2G4MqcqDuCMiJ6vRsuKgRlQPunS3xqWOepfbfjeH5317FZ87cJrUqkcb5sOJPMfmhUPu2yV
 Z3oDfpJ0DBFxxxNIPsXaFsA1MxY6Hka4PxZXKMoii9/Cm2PINKLmataGQjKxxqLpV4t3y4uxDRJ
 C4tfNiahcSp5Xu0RkMiaY7V85qLCvaUdbj6qjTauVUPU0CD3V/7gVJwaCTXyqPHetHGenuLVDcy
 mLmLyWr7zUZCgyGywL2Jg+ZsGw4rBwSE5LFNZYrYGsVq0MpIHUMwDMdZK/6x9m2jo9cFFfbSzOA
 eeIdZduDJ+KK3rKBhbw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA2MDI1MCBTYWx0ZWRfX52KDgW/zjrTK
 J62HjdEo3TmZGuDaQYHetkPGfi5id5bPejptkK6rxgwudSiU0M6MM4W2HyU1ZdrlFA20lwaCLCc
 TCp5MQTOlzqRg/TW9swwMzhywDKiDjc=
X-Proofpoint-GUID: iEJsC3CeIJtJsOT44yUOVNnzFsj6yFup
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-06_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609060250
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

SEVYX1NZU19PUEVOIGNvcGllZCBndWVzdCBieXRlcyBpbnRvIGEgZml4ZWQtc2l6ZSBidWZmZXIg
dW50aWwgaXQgZm91bmQgYSBOVUwuCkEgbWlzc2luZyB0ZXJtaW5hdG9yIGNvdWxkIG92ZXJydW4g
dGhhdCBidWZmZXIsIHNvIHVzZSBsb2NrX3VzZXJfc3RyaW5nKCkgaW5zdGVhZC4KCkZpeGVzOiA3
NzExZmRiYTg4YiAoInRhcmdldC9oZXhhZ29uOiBhZGQgbWFpbiBhcmNoLXNwZWNpZmljIHNlbWlo
b3N0aW5nIG9wZXJhdGlvbnMiKQpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FG
RUFjQTlNT3M2VmZIZjJVSFo4ejRjZHZhQis3RFk2aEpiMmVtWVoyYUxTZS10Nml3QG1haWwuZ21h
aWwuY29tLwpTdWdnZXN0ZWQtYnk6IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJv
Lm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0u
Y29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hleHN3aS5jIHwgMjcgKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyBiL3RhcmdldC9oZXhhZ29u
L2hleHN3aS5jCmluZGV4IDc1ZjBhOWNjNTIwLi5jYjZhMDYxYWYxNiAxMDA2NDQKLS0tIGEvdGFy
Z2V0L2hleGFnb24vaGV4c3dpLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMKQEAgLTI4
LDYgKzI4LDcgQEAKICNpbmNsdWRlICJzZW1paG9zdGluZy9jb25zb2xlLmgiCiAjaW5jbHVkZSAi
c2VtaWhvc3Rpbmcvc3lzY2FsbHMuaCIKICNpbmNsdWRlICJzZW1paG9zdGluZy9ndWVzdGZkLmgi
CisjaW5jbHVkZSAic2VtaWhvc3RpbmcvdWFjY2Vzcy5oIgogI2luY2x1ZGUgInN5c3RlbS9ydW5z
dGF0ZS5oIgogCiAvKiBub24tYXJtLWNvbXBhdGlibGUgc2VtaWhvc3RpbmcgY2FsbHMgKi8KQEAg
LTQ2MSwzMSArNDYyLDE0IEBAIHN0YXRpYyB2b2lkIHNpbV9oYW5kbGVfdHJhcDAoQ1BVSGV4YWdv
blN0YXRlICplbnYpCiAKICAgICBjYXNlIEhFWF9TWVNfT1BFTjoKICAgICB7Ci0gICAgICAgIGNo
YXIgZmlsZW5hbWVbQlVGU0laXTsKKyAgICAgICAgY2hhciAqZmlsZW5hbWU7CiAgICAgICAgIHRh
cmdldF91bG9uZyBwaHlzaWNhbF9maWxlbmFtZV9hZGRyOwogICAgICAgICB1bnNpZ25lZCBpbnQg
ZmlsZW1vZGU7Ci0gICAgICAgIGludCBsZW5ndGg7CiAgICAgICAgIGludCByZWFsX29wZW5tb2Rl
OwogICAgICAgICBpbnQgcmV0LCBlcnIgPSAwOwotICAgICAgICBpbnQgaSA9IDA7CiAKICAgICAg
ICAgaGV4YWdvbl9yZWFkX21lbW9yeShlbnYsIHN3aV9pbmZvLCA0LCAmcGh5c2ljYWxfZmlsZW5h
bWVfYWRkciwgcmV0YWRkcik7CiAgICAgICAgIGhleGFnb25fcmVhZF9tZW1vcnkoZW52LCBzd2lf
aW5mbyArIDQsIDQsICZmaWxlbW9kZSwgcmV0YWRkcik7Ci0gICAgICAgIGhleGFnb25fcmVhZF9t
ZW1vcnkoZW52LCBzd2lfaW5mbyArIDgsIDQsICZsZW5ndGgsIHJldGFkZHIpOwotCi0gICAgICAg
IGlmIChsZW5ndGggPj0gQlVGU0laKSB7Ci0gICAgICAgICAgICBxZW11X2xvZ19tYXNrKExPR19H
VUVTVF9FUlJPUiwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgIiVzOiBmaWxlbmFtZSB0b28g
bGFyZ2UgKCVkKVxuIiwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18sIGxlbmd0
aCk7Ci0gICAgICAgICAgICBzZW1pX2NiKGNzLCAtMSwgRU5BTUVUT09MT05HKTsKLSAgICAgICAg
ICAgIGJyZWFrOwotICAgICAgICB9Ci0KLSAgICAgICAgZG8gewotICAgICAgICAgICAgaGV4YWdv
bl9yZWFkX21lbW9yeShlbnYsIHBoeXNpY2FsX2ZpbGVuYW1lX2FkZHIgKyBpLCAxLAotICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAmZmlsZW5hbWVbaV0sIHJldGFkZHIpOwotICAgICAg
ICAgICAgaSsrOwotICAgICAgICB9IHdoaWxlIChmaWxlbmFtZVtpIC0gMV0pOwogCiAgICAgICAg
IC8qIGNvbnZlcnQgQVJNIEFOR0VMIGZpbGVtb2RlIGludG8gaG9zdCBmaWxlbW9kZSAqLwogICAg
ICAgICBpZiAoZmlsZW1vZGUgPCBBUlJBWV9TSVpFKGFuZ2VsX3RvX2hvc3RfZmlsZW1vZGVfdGFi
bGUpKSB7CkBAIC00OTgsNiArNDgyLDEyIEBAIHN0YXRpYyB2b2lkIHNpbV9oYW5kbGVfdHJhcDAo
Q1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAgICAgICAgICBicmVhazsKICAgICAgICAgfQogCisg
ICAgICAgIGZpbGVuYW1lID0gbG9ja191c2VyX3N0cmluZyhwaHlzaWNhbF9maWxlbmFtZV9hZGRy
KTsKKyAgICAgICAgaWYgKCFmaWxlbmFtZSkgeworICAgICAgICAgICAgc2VtaV9jYihjcywgLTEs
IEVGQVVMVCk7CisgICAgICAgICAgICBicmVhazsKKyAgICAgICAgfQorCiAgICAgICAgIGlmIChz
dHJjbXAoZmlsZW5hbWUsICI6dHQiKSA9PSAwICYmCiAgICAgICAgICAgICBxZW11X3NlbWlob3N0
aW5nX2NvbnNvbGVfaGFzX2NoYXJkZXYoKSkgewogICAgICAgICAgICAgcmV0ID0gYWxsb2NfZ3Vl
c3RmZCgpOwpAQCAtNTEzLDYgKzUwMyw3IEBAIHN0YXRpYyB2b2lkIHNpbV9oYW5kbGVfdHJhcDAo
Q1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAgICAgICAgICAgICAgcmV0ID0gZ3Vlc3RmZDsKICAg
ICAgICAgICAgIH0KICAgICAgICAgfQorICAgICAgICB1bmxvY2tfdXNlcihmaWxlbmFtZSwgcGh5
c2ljYWxfZmlsZW5hbWVfYWRkciwgMCk7CiAgICAgICAgIHNlbWlfY2IoY3MsIHJldCwgZXJyKTsK
ICAgICB9CiAgICAgYnJlYWs7Ci0tIAoyLjM0LjEKCg==

