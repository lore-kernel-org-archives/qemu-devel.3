Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D35ACA9ED5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG7VB-0003VZ-Oj; Mon, 12 Oct 2026 00:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7UW-0001zv-LY
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:18:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7UR-0001C7-6W
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:18:21 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C1lQl8328455
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TqYUKRSkqLmpwx6LXHLt9nFuLWDlH8GbmkD5TRt6itg=; b=gLojDGJiTB99uBsl
 BCJkY/SotSolSJyhFKTLEK8uK5UUf3yId/SJA2Tt/Y7rYIq2mvSfbIf8fTlv6kUs
 cUF1gupgpsQWMq+5n3D8mNqPgCAxMXoEi20zCwLhPT7rs5zCWF46FjxO2Jh2tZ2O
 0u2/4HurT5e5uT4kV5aiYcARJRlkBesM0I66n4dUT6KvP0RpHuuEfoqWbIJafp+4
 mKQ1A5S8mmhXTdI4Dw29Rjr/W/MrNjmqHmIWH/iA8iv/W0VhUdkPEv1KkqHKDxZL
 vC9L5Fiq0Ns61AZMh1otlUx+P35+g2zIWVXbsHJXYfH/RtMCjDvBJBaVtMXf/axF
 8I8Vzw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7e4echaq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:18:06 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-341eff9e381so4701103eec.1
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 21:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791778686; x=1792383486; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TqYUKRSkqLmpwx6LXHLt9nFuLWDlH8GbmkD5TRt6itg=;
 b=gyACeCsZWBQ2HJjGNaxkPLRqEWB4H3in9J/6PLQV8nNcWOmHDL0vqoHt0OteHT1+v1
 kZaNVHGG9R1QnLAAI8Hseny0RQ0eouS9FnaOMEdoVzZe9K/LPMO94y+v5rH2vYV1teEV
 5hI19XUSIsCbhSjuDkqR8Uy/O40Bg+aJ5Xo+4k85Fm3qnApSHqF2UQtgxBzLWqgWRA/a
 8MXX46lJuomNE5IFHb9/3mzFT5Td6Dma75FlFp/JRnRiJd8KI6F7tDcbhTQDU9knVQS+
 mLsZG3A0ml76pTxSqZOQyo5D5p13QGt6G7GyFkfsdM7m9hJCweJnexlD5AZrHprZrQwa
 VziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791778686; x=1792383486;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TqYUKRSkqLmpwx6LXHLt9nFuLWDlH8GbmkD5TRt6itg=;
 b=ax9f8rF4Kd8c2Y7jMCmdI2iUAkCVwDPp00l8SoO2FR9nVfnPpdZQd2sQPA8dqje1s5
 +WpGb2XUrnpQPxDlroXPFWsESZB2hol56KumGwuwTU2+E06UbC5n+EoxKXYoby+okozi
 b/dcrzi1WIo9d8p3o1M9Bzkf/P6W31RwYGrd4gEVZpi296mmBJvPBbvF96PqCY+SqnuH
 AOXcyvu2nfOIV2Yzw+BfIkCrjI0i9xIGmHG0ifPhap6eBVQWd2C2tS3DCe5eBpDBlyPw
 OQvDDEfSpd8gMyPx1E5F7UqcDs/WW/tMOweIESDuYCAi401yY7UsNkcannjD0lfdMoZb
 QdFg==
X-Gm-Message-State: AFq9FYIdgoBE+N5F7nvM160G7hpudtgAcpufMTDOcZKdIm50J246/0v7
 V8TxwlWdDMyidQNBkireSkdv1kbM9xc5xRmhPHUUj5LWoix0D7bkGrgUoD0a+BJ2Wzt59WqS6SU
 6hzUkEM/k+5L6lzC+n9QqF7kmZmcWeK1UwTXb2c4OigfQ1tlJ1anwYdiq6rA6hffkDw==
X-Gm-Gg: AYBFou3LgY3Lfr3n5UIcT6vbGOHEvAmPzzUH73s4kXv1c4ff5YagxRN53rH10NniG3o
 rw8hJK/RuqCKkZ5xYshO1XP4H6RqeV/XaTjOjIiq7mMzwusuX+P76hKYAS5ScQaVLSxZduTIYm6
 HAwfdtUVrPC2SgzB8VLhEisP9CqwauSEyhlQGi8QA6eK3al2aA1xmQVnKKhrosUMU1GFRzquybT
 PxbBwykiJ8oV5iXr0dlbWp6dguKrkArAUphaR+ugEPn255xl2p+YU2ka0e2VqDcIUcofxyylzzX
 oJDuQNc4SxaMjaZ9WLlL4Iy1ULutxk+QVXMB9LZF6mi50yx7AbHVGb0KVYJEgkcFOUC5YCe69Qs
 4ifk0cmlS4rJErMnqqRgLkHZy0K6n97UOgL/O3WOFVuR3dxs=
X-Received: by 2002:a05:7300:dd41:b0:34d:756:9b2a with SMTP id
 5a478bee46e88-3537e059987mr11998790eec.23.1791778685790; 
 Sun, 11 Oct 2026 21:18:05 -0700 (PDT)
X-Received: by 2002:a05:7300:dd41:b0:34d:756:9b2a with SMTP id
 5a478bee46e88-3537e059987mr11998759eec.23.1791778685241; 
 Sun, 11 Oct 2026 21:18:05 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841648sm32369096eec.3.2026.10.11.21.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 21:18:04 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 23/25] tests/tcg/hexagon: cover LL/SC reservation clearing
Date: Sun, 11 Oct 2026 21:17:20 -0700
Message-Id: <20261012041722.1159355-24-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
References: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfX90kG78huqjTv
 oVXoE5BmLW4lL/Srxm4CqwqxtFlHIAVPlj0M2aWyR0TeUA34ou35geD8wuy8qUXvvREcYb6pxEc
 MQ6Mju9h6ubJoTe2Rph/UJ3AAFv5C6AVJk58WVctStnMj0gdIVCQsTOFoGnNy4p+FsHJV7ZwCsy
 VFhuKUsgFe4jr8TgPwhbbZPKEBuLvG1wlaf3v3blRu3bZip/sBMjtDwu0CZG5rKuWC389uIX3XO
 c/1qlxxAuOegB+8NqPz1G1riqdOsMUF3Kx574P3qUpbtSYwiiyJEpNUVZWCoMsItFjC4ow0CNuW
 F2idhrpJm/En4yEHOLGIy5rH5kSCqPTtq54fdFkU4RaluelQf1maF5+VVZwBaTZeSmvErsqBax4
 C6+S29FOOqswjnWiEYZBfgT9dqUQY2ULbz2VIha6TrT/YI4/E+K0gtn8/7psMLqGbh7vms01pyJ
 ZlqVlQOX7LmfqAd4HIA==
X-Proofpoint-ORIG-GUID: PiBaLTbOH3r3O48VNNYq8Ceat7CN94o8
X-Proofpoint-GUID: PiBaLTbOH3r3O48VNNYq8Ceat7CN94o8
X-Authority-Analysis: v=2.4 cv=W5utxhWk c=1 sm=1 tr=0 ts=6acc5f7e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=OvsSgjh5XwAxDixGgywA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfXxg3NU4V3qi5V
 igOwPgEdAVZGfoBH8XWPo7CNzM1VNAfCrbbQlbl318hTWiwKbmTY3hwueJoxLvosopvx7bczlMP
 x3K8heRiCoS59EZRYJ6kvIoQXrLRiz8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
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

QWRkIGxvYWQtbG9ja2VkIGFuZCBzdG9yZS1jb25kaXRpb25hbCBoZWxwZXJzIGFuZCBjaGVjayB0
aGF0IGEKc3RvcmUtY29uZGl0aW9uYWwgd2l0aCBubyBwcmVjZWRpbmcgbG9hZC1sb2NrZWQgZmFp
bHMsIGFuZCB0aGF0IHJldHVybmluZwpmcm9tIGEgc3lzY2FsbCBkcm9wcyB0aGUgcmVzZXJ2YXRp
b24uCgpSZXZpZXdlZC1ieTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxjb21t
LmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0u
Y29tPgotLS0KIHRlc3RzL3RjZy9oZXhhZ29uL2F0b21pY3MuYyB8IDQwICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA0MCBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vYXRvbWljcy5jIGIvdGVzdHMvdGNnL2hl
eGFnb24vYXRvbWljcy5jCmluZGV4IDFjMjE2OWIyOGJkLi41MDE3Y2EwMDNmMSAxMDA2NDQKLS0t
IGEvdGVzdHMvdGNnL2hleGFnb24vYXRvbWljcy5jCisrKyBiL3Rlc3RzL3RjZy9oZXhhZ29uL2F0
b21pY3MuYwpAQCAtMjcsNiArMjcsMzAgQEAgaW50IGVycjsKIAogI2luY2x1ZGUgImhleF90ZXN0
LmgiCiAKK3N0YXRpYyBpbmxpbmUgaW50MzJfdCBsb2FkX2xvY2tlZDMyKGludDMyX3QgKngpCit7
CisgICAgaW50MzJfdCB2YWx1ZTsKKworICAgIF9fYXNtX18gX192b2xhdGlsZV9fKCIlW3ZhbHVl
XSA9IG1lbXdfbG9ja2VkKCVbYWRkcl0pIgorICAgICAgICAgICAgICAgICAgICAgICAgIDogW3Zh
bHVlXSAiPXIiKHZhbHVlKQorICAgICAgICAgICAgICAgICAgICAgICAgIDogW2FkZHJdICJyIih4
KQorICAgICAgICAgICAgICAgICAgICAgICAgIDogIm1lbW9yeSIpOworICAgIHJldHVybiB2YWx1
ZTsKK30KKworc3RhdGljIGlubGluZSBpbnQgc3RvcmVfY29uZGl0aW9uYWwzMihpbnQzMl90ICp4
LCBpbnQzMl90IHZhbHVlKQoreworICAgIGludCByZXN1bHQ7CisKKyAgICBfX2FzbV9fIF9fdm9s
YXRpbGVfXygKKyAgICAgICAgIm1lbXdfbG9ja2VkKCVbYWRkcl0sIHAwKSA9ICVbdmFsdWVdXG5c
dCIKKyAgICAgICAgIiVbcmVzdWx0XSA9IHAwIgorICAgICAgICA6IFtyZXN1bHRdICI9ciIocmVz
dWx0KQorICAgICAgICA6IFthZGRyXSAiciIoeCksIFt2YWx1ZV0gInIiKHZhbHVlKQorICAgICAg
ICA6ICJwMCIsICJtZW1vcnkiKTsKKyAgICByZXR1cm4gcmVzdWx0ICE9IDA7Cit9CisKIHN0YXRp
YyBpbmxpbmUgaW50MzJfdCBhdG9taWNfaW5jMzIoaW50MzJfdCAqeCkKIHsKICAgICBpbnQzMl90
IG9sZCwgZHVtbXk7CkBAIC04OSw2ICsxMTMsMjEgQEAgc3RhdGljIGlubGluZSBpbnQ2NF90IGF0
b21pY19kZWM2NChpbnQ2NF90ICp4KQogdm9sYXRpbGUgaW50MzJfdCB0aWNrMzIgPSAxOyAvKiBV
c2luZyB2b2xhdGlsZSBiZWNhdXNlIHdlIGFyZSB0ZXN0aW5nIGF0b21pY3MgKi8KIHZvbGF0aWxl
IGludDY0X3QgdGljazY0ID0gMTsgLyogVXNpbmcgdm9sYXRpbGUgYmVjYXVzZSB3ZSBhcmUgdGVz
dGluZyBhdG9taWNzICovCiAKK3N0YXRpYyB2b2lkIHRlc3RfcmVzZXJ2YXRpb25zKHZvaWQpCit7
CisgICAgaW50MzJfdCB2YWx1ZSA9IDE7CisKKyAgICAvKiBBIHN0b3JlLWNvbmRpdGlvbmFsIHdp
dGggbm8gcHJlY2VkaW5nIGxvYWQtbG9ja2VkIG11c3QgZmFpbC4gKi8KKyAgICBjaGVjazMyKHN0
b3JlX2NvbmRpdGlvbmFsMzIoJnZhbHVlLCAyKSwgMCk7CisgICAgY2hlY2szMih2YWx1ZSwgMSk7
CisKKyAgICAvKiBSZXR1cm5pbmcgZnJvbSBhIHN5c2NhbGwgZHJvcHMgdGhlIHJlc2VydmF0aW9u
LiAqLworICAgIGNoZWNrMzIobG9hZF9sb2NrZWQzMigmdmFsdWUpLCAxKTsKKyAgICBnZXRwaWQo
KTsKKyAgICBjaGVjazMyKHN0b3JlX2NvbmRpdGlvbmFsMzIoJnZhbHVlLCAzKSwgMCk7CisgICAg
Y2hlY2szMih2YWx1ZSwgMSk7Cit9CisKIHZvaWQgKnRocmVhZDFfZnVuYyh2b2lkICphcmcpCiB7
CiAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBMT09QX0NOVDsgaSsrKSB7CkBAIC0xMjIsNiArMTYx
LDcgQEAgdm9pZCB0ZXN0X3B0aHJlYWQodm9pZCkKIAogaW50IG1haW4oaW50IGFyZ2MsIGNoYXIg
Kiphcmd2KQogeworICAgIHRlc3RfcmVzZXJ2YXRpb25zKCk7CiAgICAgdGVzdF9wdGhyZWFkKCk7
CiAgICAgcHV0cyhlcnIgPyAiRkFJTCIgOiAiUEFTUyIpOwogICAgIHJldHVybiBlcnI7Ci0tIAoy
LjM0LjEKCg==

