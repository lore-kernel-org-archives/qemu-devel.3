Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACAD606A31F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 02:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=anWGBupB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=alTMd6yX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIzCn-000109-PT; Mon, 19 Oct 2026 22:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIzCm-0000zy-Jo
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 22:03:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIzCk-0003iv-Ef
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 22:03:56 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0tW5D1255247
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 02:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TmGsq01z4wi/rE4LEFDSrdwepUkWj7C4ncGwvjAmEP4=; b=anWGBupBeftlqDl+
 lBWIVszUg8ObHNe1PvG1EQ8xiVHHD00YpijSBx4SCyBRiS+afCCzeZq8OkasVE2X
 zaeCeo+WCOZ0kEfduV8xIsh2VxohjJnZ94ENMgvjrlZMZytQOnTLrullLc7jXe3H
 fId5vADfZyGGCH3vOv+c/hLZ1y4PRRGHue24sZvpB0iYBBhrac5snry6p8Zkgoo/
 +DNPh9VyqTYxplA1xHLcNg1hmlykv1pfww1xIq9VKZp2iyMxwZnk59xh0oVzZBGG
 huuPpa7pt2ymzAGhW3n77/THiu9goWCD7Cw6QfsCXweT+nz5IrICJms/6tQEX0Wj
 R7lNpw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n8cm4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 02:03:52 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3510d0baf63so6872898eec.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 19:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792461831; x=1793066631; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TmGsq01z4wi/rE4LEFDSrdwepUkWj7C4ncGwvjAmEP4=;
 b=alTMd6yXPSiWWf47oGdbarZ3x079m3ABOSz85ruBSIuHUQCQ2pHxXLmdwmCjXvIThn
 1V78tnO2k7NnpdY3XOdmn3l8y73SiyhpRqB+OnrCfY57fMgCxo42yuVMQl+pZZIO8H5u
 LAc36VbfSizqamD+ZXvNv0Ej1mgTDKUAwlJ01FFs5inxM/DreYJ5TypzXB3RDTH6p45f
 DXi3Qt5znfVrKQ+Zoo9zqRsfMONdIvriOEQv1OIZiJ+Fvjw6V52BUCMO5aUAgV3GkBNp
 9Jttzi1QtoPbGCiNGOTU+KD/cbedX3EmeLmw/p8VxlInwoHAMZeXuaxyn7GjEEYHQWqL
 ZTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792461831; x=1793066631;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TmGsq01z4wi/rE4LEFDSrdwepUkWj7C4ncGwvjAmEP4=;
 b=nXqGFZYpuRop6UdT3u0+OZEsXNjXV/2FPOjWVgYV/+6u+UIBeCGuhp1NLyfqi9xKOv
 aL3UQpSYh750MR6kWAywQlKtG7m+tokeB7etE5wpKk+UYu5te4vCnjPqqEwknaldPOgH
 b1qSwALVKzsFwWgbi2KCZWCLF8UuutqcQVLRRQdLGPi3di6fQcxdWpZ7a0wtv8Sv2S9N
 RS2G23q96bZjEnxxGZWQHWBSs4qk6sAJIXuy+vCLug+snESBjmwbJ0i21psdJbJ2C9Aw
 iLf+XkjrQEM8OP0l1YmhP0ogUSHXAsLzWZUTVrtPP9NPXjK7wGhRXxBToTT5e57Pqucm
 eeWA==
X-Gm-Message-State: AFq9FYKxVn4UQmTLeRHO3jdkfg1eTNb4Z3km3QHibfWD4klVrfeYxCLC
 mO/2SzRzhBdVOEab0GXTn/0APiz3Ag7yvxCEJApFOYfN/xpa4qGYyUg9XZ9FLEwoxKpx3KYrup2
 8+VzXX4nrggx7B52bt2s3N7hR9AF0nF7Ox8Yq7PKU4lNn+LIkHC5JhsMawoS7Hkj4Ng==
X-Gm-Gg: AYBFou2VKIMC8GFv1ul2nR9Z8zEnIsKGQl4XPs/kjD6CbnGjbC3G9+/YtN9M3lwIVrW
 kqRLG0HZlSLScRK1IGoAQA3TG9FAgY4RebWDGrOflRbJ7qcM4WZ5ZMHmVWfr0xtw/a/3DDe3IFZ
 Y/3Tmp5ExzoOvoRFRhxMEf8zXFZG2J/J6JiW2f0uP1oViHx2FjJz7CycuGdzi4dKqhbG7H1txWw
 DRwjkFsi2VLJwRw0qViLKF3lMvFXIvNWNHeTRrOqa21CDmUeZxGh7U0f2Lqxl360lWYA52rSsGA
 LzZU9WLi2NYwH84A1O9WzU79FxWFFIQ1ZcGyMmlkPqVv1HPhP8tMMOBHUdECUnxK18Ue5g7XAX+
 M8uB0BDcmo31X1w0pcD2RIE+xqy+OD95LcwJi0KsoPttpvapG
X-Received: by 2002:a05:7022:150e:b0:141:b2c3:d84e with SMTP id
 a92af1059eb24-185120a8bb4mr15651524c88.11.1792461831088; 
 Mon, 19 Oct 2026 19:03:51 -0700 (PDT)
X-Received: by 2002:a05:7022:150e:b0:141:b2c3:d84e with SMTP id
 a92af1059eb24-185120a8bb4mr15651502c88.11.1792461830562; 
 Mon, 19 Oct 2026 19:03:50 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831a6f58c2sm49452078c88.11.2026.10.19.19.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 19:03:48 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, peter.maydell@linaro.org,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 2/4] target/hexagon: fix semihosting OPEN filename handling
Date: Mon, 19 Oct 2026 19:03:40 -0700
Message-Id: <20261020020342.3619566-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261020020342.3619566-1-brian.cain@oss.qualcomm.com>
References: <20261020020342.3619566-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: h_b0_gUcRTKJ_pVN9u7K7S3lVNVdCfR1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAwNyBTYWx0ZWRfX4bsTNDQ8hVP8
 ANr79f4e5i0k6+P+dibBQJ2ba6b1qlCMpwxnsFNki9juUUokaC0SMLgJAzTxW8ZSbLqlCFHhKxB
 SPB29WUFeOm3UJVjHxAscgMsBOLpbedyLBTQa0aVgldNZuvNsXZJrx84at1bM0F8h303Qh5DqgL
 KlDvD+XOl4cTD2VyIBMY/YL3p3MBlmsf5n5sT7IyPjewmE9uK73e7BIoyAowweKw5+HTghvAlmo
 pZM6kNrQOa1W7B73aLyFD6CT8jBn07+wza/EgT5I+pcj3mNS/FkXg+a9qq2wqUJGjHy2BUnmPLa
 Mwohmq+TtZXW8IOQKy2bYb1PM1MZSYxafJjQQOSCccNoMQvPATaKtpHsl1RI8f0TJWM4uX4gya2
 mLiDw9M4EjT9nGtTGH+Tk3rv1kQoXM9ZUpBEHht9narT282CvO+wFpKflXQ4U81VNZDtB17Bfb5
 Ub8VZtNrArqqZ4OourQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAwNyBTYWx0ZWRfX6aiBufhanR3Y
 315vJea3L+g8eVih7+JcHsn8xrEOY1W0WIwXlxQzn1/GzEjRrGP9r3MXJQPKfFCbHo12YnA95A4
 +yMtXiEuxVGHN9uInfecS+z6agArLmU=
X-Authority-Analysis: v=2.4 cv=VI9IDNPX c=1 sm=1 tr=0 ts=6ad6cc08 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=wfIhpZVs-6LWPqknoVUA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: h_b0_gUcRTKJ_pVN9u7K7S3lVNVdCfR1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200007
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

SEVYX1NZU19PUEVOIGNvcGllZCBndWVzdCBieXRlcyBpbnRvIGEgZml4ZWQtc2l6ZSBidWZmZXIg
dW50aWwgaXQgZm91bmQgYQpOVUwuIEEgbWlzc2luZyB0ZXJtaW5hdG9yIGNvdWxkIG92ZXJydW4g
dGhhdCBidWZmZXIuIFVzZSBsb2NrX3VzZXIoKSB3aXRoCnRoZSBBQkkgZmlsZW5hbWUgbGVuZ3Ro
IGFuZCB2YWxpZGF0ZSBpdHMgdGVybWluYXRpbmcgTlVMIGJlZm9yZSBvcGVuaW5nIGl0LgoKRml4
ZXM6IDc3MTFmZGJhODhiICgidGFyZ2V0L2hleGFnb246IGFkZCBtYWluIGFyY2gtc3BlY2lmaWMg
c2VtaWhvc3Rpbmcgb3BlcmF0aW9ucyIpCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC9DQUZFQWNBOU1PczZWZkhmMlVIWjh6NGNkdmFCKzdEWTZoSmIyZW1ZWjJhTFNlLXQ2aXdAbWFp
bC5nbWFpbC5jb20vClN1Z2dlc3RlZC1ieTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBs
aW5hcm8ub3JnPgpSZXZpZXdlZC1ieTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5h
cm8ub3JnPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29t
bS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMgfCAzMCArKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxNyBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyBiL3RhcmdldC9o
ZXhhZ29uL2hleHN3aS5jCmluZGV4IGEyOGY4MzUxNWZiLi5jYzQ4YzliYTlmMSAxMDA2NDQKLS0t
IGEvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMK
QEAgLTQ2OSwzNSArNDY5LDI5IEBAIHN0YXRpYyB2b2lkIHNpbV9oYW5kbGVfdHJhcDAoQ1BVSGV4
YWdvblN0YXRlICplbnYpCiAKICAgICBjYXNlIEhFWF9TWVNfT1BFTjoKICAgICB7Ci0gICAgICAg
IGNoYXIgZmlsZW5hbWVbQlVGU0laXTsKKyAgICAgICAgY2hhciAqZmlsZW5hbWU7CiAgICAgICAg
IHRhcmdldF91bG9uZyBwaHlzaWNhbF9maWxlbmFtZV9hZGRyOwogICAgICAgICB1bnNpZ25lZCBp
bnQgZmlsZW1vZGU7Ci0gICAgICAgIHVpbnQzMl90IGxlbmd0aDsKKyAgICAgICAgdWludDMyX3Qg
ZmlsZW5hbWVfbGVuOworICAgICAgICBzaXplX3QgZmlsZW5hbWVfc2l6ZTsKICAgICAgICAgaW50
IHJlYWxfb3Blbm1vZGU7CiAgICAgICAgIGludCByZXQsIGVyciA9IDA7Ci0gICAgICAgIGludCBp
ID0gMDsKIAogICAgICAgICBpZiAoZ2V0X3VzZXJfdTMyKHBoeXNpY2FsX2ZpbGVuYW1lX2FkZHIs
IHN3aV9pbmZvKSB8fAogICAgICAgICAgICAgZ2V0X3VzZXJfdTMyKGZpbGVtb2RlLCBzd2lfaW5m
byArIDQpIHx8Ci0gICAgICAgICAgICBnZXRfdXNlcl91MzIobGVuZ3RoLCBzd2lfaW5mbyArIDgp
KSB7CisgICAgICAgICAgICBnZXRfdXNlcl91MzIoZmlsZW5hbWVfbGVuLCBzd2lfaW5mbyArIDgp
KSB7CiAgICAgICAgICAgICBnb3RvIGRvX2ZhdWx0OwogICAgICAgICB9CiAKLSAgICAgICAgaWYg
KGxlbmd0aCA+PSBCVUZTSVopIHsKLSAgICAgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNU
X0VSUk9SLAotICAgICAgICAgICAgICAgICAgICAgICAgICAiJXM6IGZpbGVuYW1lIHRvbyBsYXJn
ZSAoJSIgUFJJdTMyICIpXG4iLAotICAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywg
bGVuZ3RoKTsKLSAgICAgICAgICAgIHNlbWlfY2IoY3MsIC0xLCBFTkFNRVRPT0xPTkcpOwotICAg
ICAgICAgICAgYnJlYWs7CisgICAgICAgIC8qIFRoZSBBQkkgbGVuZ3RoIGV4Y2x1ZGVzIHRoZSBm
aWxlbmFtZSdzIHRlcm1pbmF0aW5nIE5VTC4gKi8KKyAgICAgICAgZmlsZW5hbWVfc2l6ZSA9IChz
aXplX3QpZmlsZW5hbWVfbGVuICsgMTsKKyAgICAgICAgZmlsZW5hbWUgPSBsb2NrX3VzZXIoVkVS
SUZZX1JFQUQsIHBoeXNpY2FsX2ZpbGVuYW1lX2FkZHIsCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGZpbGVuYW1lX3NpemUsIHRydWUpOworICAgICAgICBpZiAoIWZpbGVuYW1lIHx8IGZp
bGVuYW1lW2ZpbGVuYW1lX2xlbl0gIT0gJ1wwJykgeworICAgICAgICAgICAgdW5sb2NrX3VzZXIo
ZmlsZW5hbWUsIHBoeXNpY2FsX2ZpbGVuYW1lX2FkZHIsIDApOworICAgICAgICAgICAgZ290byBk
b19mYXVsdDsKICAgICAgICAgfQogCi0gICAgICAgIGRvIHsKLSAgICAgICAgICAgIGlmIChnZXRf
dXNlcl91OChmaWxlbmFtZVtpXSwgcGh5c2ljYWxfZmlsZW5hbWVfYWRkciArIGkpKSB7Ci0gICAg
ICAgICAgICAgICAgZ290byBkb19mYXVsdDsKLSAgICAgICAgICAgIH0KLSAgICAgICAgICAgIGkr
KzsKLSAgICAgICAgfSB3aGlsZSAoZmlsZW5hbWVbaSAtIDFdKTsKLQogICAgICAgICAvKiBjb252
ZXJ0IEFSTSBBTkdFTCBmaWxlbW9kZSBpbnRvIGhvc3QgZmlsZW1vZGUgKi8KICAgICAgICAgaWYg
KGZpbGVtb2RlIDwgQVJSQVlfU0laRShhbmdlbF90b19ob3N0X2ZpbGVtb2RlX3RhYmxlKSkgewog
ICAgICAgICAgICAgcmVhbF9vcGVubW9kZSA9IGFuZ2VsX3RvX2hvc3RfZmlsZW1vZGVfdGFibGVb
ZmlsZW1vZGVdOwpAQCAtNTA1LDYgKzQ5OSw3IEBAIHN0YXRpYyB2b2lkIHNpbV9oYW5kbGVfdHJh
cDAoQ1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAgICAgICAgICBxZW11X2xvZ19tYXNrKExPR19H
VUVTVF9FUlJPUiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgIiVzOiBpbnZhbGlkIE9QRU4g
bW9kZTogJXVcbiIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBmaWxlbW9k
ZSk7CisgICAgICAgICAgICB1bmxvY2tfdXNlcihmaWxlbmFtZSwgcGh5c2ljYWxfZmlsZW5hbWVf
YWRkciwgMCk7CiAgICAgICAgICAgICBzZW1pX2NiKGNzLCAtMSwgRUlOVkFMKTsKICAgICAgICAg
ICAgIGJyZWFrOwogICAgICAgICB9CkBAIC01MjQsNiArNTE5LDcgQEAgc3RhdGljIHZvaWQgc2lt
X2hhbmRsZV90cmFwMChDUFVIZXhhZ29uU3RhdGUgKmVudikKICAgICAgICAgICAgICAgICByZXQg
PSBndWVzdGZkOwogICAgICAgICAgICAgfQogICAgICAgICB9CisgICAgICAgIHVubG9ja191c2Vy
KGZpbGVuYW1lLCBwaHlzaWNhbF9maWxlbmFtZV9hZGRyLCAwKTsKICAgICAgICAgc2VtaV9jYihj
cywgcmV0LCBlcnIpOwogICAgIH0KICAgICBicmVhazsKLS0gCjIuMzQuMQoK

