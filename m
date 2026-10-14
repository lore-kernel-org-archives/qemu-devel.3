Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B113CC6B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH51o-0005U4-HE; Wed, 14 Oct 2026 15:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH51m-0005Te-Qf
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:52:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xH51l-0002Vz-7w
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:52:42 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EGZhOZ3468832
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MID4scM9nvtrN/Imhj8jnn4lLsAnRSYfC1HhIGzeyqs=; b=kgXgGXSFXTpuoLA7
 PFrCIwwPtSCdkpWLLeHenAcsGki/jXFYrTgJ7/6ifxgGRLh3+ZVF6bUQC765QDSx
 y5CQZKc0cqEERTqHdrVHMigSk47Wd+naCuBJCEqSpT/gJ9iWqiVHgUqlSfRRIPMx
 sagwmTZJ8VAjl/GtXYKoDOjacaSpmUlnIXnTAfeE8ggtI6ADuz/LpXH1aP4lQAGg
 ET+SM6FOMk7OZlgDr//wWqjpdmecbqVfwtI/oL0EviethuS2URuG91zDfGOjGGpM
 ijw6HkczS7jbmEDPtEVAhVP0fU8XQZD9x1GiqgqY1LjSGQ8y9cSiyY90uxnZckvY
 meyWnw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hadd78r2t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:52:39 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35d4538fd74so4127095eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 12:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792007559; x=1792612359; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MID4scM9nvtrN/Imhj8jnn4lLsAnRSYfC1HhIGzeyqs=;
 b=drjGCtnnOq6F0ATUHt68/RVWdPZX5A+f8JjMF1IzDfG5zhdc9MjDl0SoMKlB048JPx
 cG/TB41L/ScHHeVkT63slVWHeRCv7MvPUoMPHNkRvkxjIp4sYeV0WzjiB/kgG/upWvwG
 /FAWAO4L3D4Nua/N0CDFJkfnsYBTQo2Lspeg1GmQgrgK0m0YPKuK3L0u78ee5dSiMbg6
 fizA1S7cPO2MZb7SHxouAIUaOdWbvijWlu0C4BKa9w/WWJgOaYS0mwKdjHXK6bgFCarq
 SonqMyPD40863XpeKUbTLRt9XkyYbOSEQRvnJxbCmDiQoYjRhAUONzqk4RYVD/vWj5D0
 QMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792007559; x=1792612359;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MID4scM9nvtrN/Imhj8jnn4lLsAnRSYfC1HhIGzeyqs=;
 b=ULPK51jTYYdyXaewVMhNHozmazIwO4Sc8go79OyDcKh+2ayeO85au/eLLEz3GcUS1V
 5VnwiyilubOhxNIQHeCJXcdekdJ/an6QqmuQqd7UkVtAeR7mjUgozVgKxlOG6oYrKxj3
 uIHJuTbnq1K+0dmH1Tf6mWdITI+oxI9Bmwo9rnarx9KQE0vtTOsme+Tu3UJeRO0MqF+G
 a1tEUkyLICGjZMZCSO+holqpkCWK/eezo8qOr2xV5Zi0KGDtF7hp3a0Okjj12DcQ4hv3
 a8omPbmWKFRYz2DHxIpzTvDgkDswdO7SmIdNRmaveMQzqde8CsqVt1YGbjso0AQuuZzB
 IWZw==
X-Gm-Message-State: AFq9FYIj9LN6czjE4KWdovEPRZ8iUbEoMDh4huGjE1kgp6pPjdH65h4r
 DbqrYNfZ5Bor5fSeRukZcQCHECYdhuTy5YRX68NQ+DO/MIxa0Fh6jtU3OZ2nuMS8WLvba6LWhN1
 DOm34x58QNo9s7ZIubcQvUOwbCkZ8pUmOs9YDVwih3c36cULK5ADgydBki//FJ5mN6g==
X-Gm-Gg: AYBFou3YLO3awbs181SpD1O+cnCUAt8pNqOlf3ZgUbhVsUqyd6FRongi2C9iEktM7wk
 +sQvJmCo8Vg0bEc1n9eicIO2ew5bjuLUQY+GuTWtETN/8VgzeRZdYQCQRRv2sx/LxLabequfgn6
 fmRSX85ai9295IuEABrLUr5ptiUVoqnPhZSdLUtuoe1+B0IwVhFBJDnIj9DydRuFzmpuvK5XA9r
 ckHbhDtMEkJRi/L7IYv3cwBSTajF5/Icq44SSBXJ47i2Cc17N8+LtKgWyr91sVv7U0JdPDoCJno
 2yTdJi48VuiH8ZfBMqtRyl6X8sk9tu0g3cSdEM9G2W3nr17lbZuJQ1Z/Gs4zgpcbdUR+uKGEWHJ
 Q7FXlrfj19lylj8DfAqyvVJEMN2vaX3dDKmseuey0doJ08M0=
X-Received: by 2002:a05:693c:2503:b0:35d:7c75:1b40 with SMTP id
 5a478bee46e88-35d7c75232bmr5250419eec.18.1792007558986; 
 Wed, 14 Oct 2026 12:52:38 -0700 (PDT)
X-Received: by 2002:a05:693c:2503:b0:35d:7c75:1b40 with SMTP id
 5a478bee46e88-35d7c75232bmr5250273eec.18.1792007555583; 
 Wed, 14 Oct 2026 12:52:35 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35f0c3bcf80sm547069eec.7.2026.10.14.12.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 12:52:35 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Alessandro Di Federico <ale@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH 08/12] target/hexagon: reject reserved L4_loadw_phys encoding
 from v83
Date: Wed, 14 Oct 2026 12:52:19 -0700
Message-Id: <20261014195223.3233623-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=BaVNQbt2 c=1 sm=1 tr=0 ts=6acfdd87 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=1bf_TWyPOMXRQjeeA18A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: k95ncNb4d2cda3Cytb9tdGYaMxVKChsC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OSBTYWx0ZWRfX46HdVuv5NfWT
 uLLe4011zRlISqaODSVZrukkolrzXloFwJ4iqTZl5ANSVFcLE7TbVYwaxYRo6bJpoRutUgqe4cc
 3Ee7B9KubaRx4DK2NT1YQl7z9tRufDAORzq/j7Ik58SL8qlQ2SPpxwZmG3we1OTkmSESLo3wKun
 33e1HosuZQIA5eqRTWcOx9RBBYuEZ1y2az0SnHQKd7OUZe3tV6wUG3L5me1/ITC268/X5oGeCtu
 vFmkP32pShaMsuK0m3O28qEc3cHoHuvNGT4rMMh0U8rXvc8npbCLNpXm7kRTCJxyMtbJ5znb1YB
 eXUKtVHbDJPZjaHtK2IGsSUkjxOQIhJH8K11SB//F3MM/zk/xCipvwafU6rLASRr6Rfi1mW/hes
 douSh/ciLvFjVUJsiLgn3p2KW6VGovF73ZG4OfnM8ZZIl+WO17/gLKqfHs7epTx4sxYkOTl+MMp
 NA7M/gRFc3ZhhwIJSRw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OSBTYWx0ZWRfXwyBEq6tHHzG9
 zJnkIJyTeNyFYpr1/5MaTrg+N75/0d9Dqujzosn9KTHabpFmr9OqhNRecQ5WKic78Gg22zYdSsc
 3xIrYAZqhg36KsdnS3I7dllfK/90Ezc=
X-Proofpoint-ORIG-GUID: k95ncNb4d2cda3Cytb9tdGYaMxVKChsC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140079
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

Qml0IDcgb2YgTDRfbG9hZHdfcGh5cyBpcyB2YWxpZCB0aHJvdWdoIHY4MSBidXQgcmVzZXJ2ZWQg
c3RhcnRpbmcKd2l0aCB2ODMuIERlY29kZSBpdCBhcyBhIGxlZ2FjeSBkb24ndC1jYXJlIGJpdCwg
dGhlbiByZWplY3QgaXQgZm9yIHY4MwphbmQgbGF0ZXIuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBD
YWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vZGVj
b2RlLmMgfCA1ICsrKysrCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0t
Z2l0IGEvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMgYi90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYwpp
bmRleCA4OWU5NjEzMzFmZi4uOWU4ZmY1ZDYwOGMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29u
L2RlY29kZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jCkBAIC03MjEsNiArNzIxLDEx
IEBAIGludCBkZWNvZGVfcGFja2V0KERpc2FzQ29udGV4dCAqY3R4LCBpbnQgbWF4X3dvcmRzLCBj
b25zdCB1aW50MzJfdCAqd29yZHMsCiAgICAgICAgICAgICAvKiBJbnZhbGlkIGluc3RydWN0aW9u
IGVuY29kaW5nICovCiAgICAgICAgICAgICByZXR1cm4gMDsKICAgICAgICAgfQorICAgICAgICAv
KiBCaXQgNyBvZiBMNF9sb2Fkd19waHlzIGJlY2FtZSByZXNlcnZlZCBpbiB2ODMuICovCisgICAg
ICAgIGlmIChjdHgtPmhleF9kZWYtPmhleF92ZXJzaW9uID49IEhFWF9WRVJfVjgzICYmCisgICAg
ICAgICAgICBpbnNuLT5vcGNvZGUgPT0gTDRfbG9hZHdfcGh5cyAmJiAoZW5jb2RpbmczMiAmIDB4
ODApKSB7CisgICAgICAgICAgICByZXR1cm4gMDsKKyAgICAgICAgfQogICAgICAgICAvKgogICAg
ICAgICAgKiBJZiB3ZSBzYXcgYW4gZXh0ZW5kZXIsIG1hcmsgbmV4dCB3b3JkIGV4dGVuZGVkIHNv
IGltbWVkaWF0ZQogICAgICAgICAgKiBkZWNvZGUgd29ya3MKLS0gCjIuMzQuMQoK

