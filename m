Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BC0606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 01:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mIYG2MZx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fMm8qvru
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK4T7-00076h-II; Thu, 22 Oct 2026 21:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4RK-0001gv-EM
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK4RI-0006KI-GY
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 21:51:26 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N1FrfT429249
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 R4OXKbz9uHTP2OC9tYZ5psP0k7mQsgSbq64oqAFTH7o=; b=mIYG2MZx5N36r6pR
 ul7nr+gbxqa3mhVA1drFaUJS8rbhAUTGin7yS4M34wq5xDIQS6gwXt7HqyHsen6z
 kq6HULD4jJcMohgs+pJRdT8qbl5EW8siSBupcZZiOdoBhupcXPHOxQ7Xg5H7dh1L
 Q1hHLIfW4HZzHMr0Kd0poShC53VSu/yFAN8TIvbgzTSS/d74Wka+wgHNJi4l+mFj
 yyxLJ233hVgtuX9Dfuqvyqm2fS2f9Kw+QplgWtOswozZllZJxSmzwwBkOIRDgvtg
 y7q1vYKVVZxqKAoRwKI6NIFv0lsnoRoKaV28Zw6nDIra16/JopYnQvSPxpk5UsQG
 NRuK6A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms1b7d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 01:51:13 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35c3c370b17so679518eec.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792720272; x=1793325072; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R4OXKbz9uHTP2OC9tYZ5psP0k7mQsgSbq64oqAFTH7o=;
 b=fMm8qvru8fDa9/++sFpqiFdv4ArT/8Edv45A7wzUyQd/yBmokmca1TXXGsZbTW4HQ/
 o97agHhjStiBHbMyzeVx2nPUPwUz3unOdnMAHkKNEZVgVXAejMg696zKhbovy0TgkwwG
 Hd/ae8LbLuildSOQTbshRM1fT4VupGycngzT6L2E0TeAYKsxVZdPvZLbvIs/b0m67n+X
 DCFjFlevQZiWnGLATgLxBwvO/vREVtH1Vfp9nyb2TbgD4IupOlpoWXLighpUfoAz4XWF
 ho6BIRPRDrzZmi88cCdsLpmxNHIJcwZxO6NMjo8fmm5CWmqntvrL5QzSR9ML+1Pfvo13
 Ycsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792720272; x=1793325072;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R4OXKbz9uHTP2OC9tYZ5psP0k7mQsgSbq64oqAFTH7o=;
 b=VdkkWpzU+CL7+w1twIrz8bxb7LnqqF3FQd94bcnHmIcHnI6OujUbFThn51769aMW4v
 jBiiGSxnIT0svdyzSvdIn9TTaJrzCY4VmjLJalqIzlDG00/CSU4qY2CjnLOZHfbbtjeT
 XiX9+hImfq9LJZAqIRpWDQ66nk0VO5WOlhTZpxS6MpbkVsSlG9Wiu5EsL8P80ptyg/q/
 xw42ODidalc+DRymEDDjAjaXnWi5Le0JzRqx1yQuRhfkNT012i7PvF7QNlM8C8lGXQH8
 7Nhpm7RaxbDXJIkCvdDXJRI+G8A8Hrr5hlWMdCU8FFlKe4If4Ezm1vFJVfQ+UBr4CGtc
 qPzQ==
X-Gm-Message-State: AFq9FYJnLn+3YFC0Wn8ZWEC0KN+A0eTWxTs9AmTL8F1gBOnZHD5P3VZ+
 /VC7rsy01Gs2yJlaNpfcMoZfygEg06uoH3CIEqnTArqi93HiMWeuEEUF+buOmbTCSjwRO+uR8p9
 TKxPNUeFu4X7S0emX0EvK6w3MntEZ/vxtU+KPfu7vzFwJcMNHZI1//s4rQOtWNQcw1Q==
X-Gm-Gg: AYBFou1Sjmuo9lSYM4KWQz3S+xccw44ypwagCSwEaWzkE+lJmdDbNfzPqP5yZFrOtCz
 kqM+uAnw5r6Z67TuH5qk7WOLufSNOWuvCMk9sEmZMTuP2PGpmrQFCiWWyICHhF8KcfiPNlWvcPi
 Og7NzJDk8+Kpp8ZWsQLl4pS5Pzcp20v4F9Ch3NlDCRN4BAwjtk1v2F2TlWTw7fSnqf8JVNrUAqa
 DeScFQKLeEV9VHb/8MBUZVcp10cER3t7oXavUuBc9KG1pekPTLt6c7bduLvc6tDDhwNbciQ06cQ
 xbeAlj99oPaUd2Fbg/Pq+2nQTm2HhMnJMkBM6UssLL8zTMUSAelb/ACzrSwlTx2VQK+c7yMQAjH
 IBsPiHhGIrGs5tiGsG3MdMWTxYRp4tBhWJ9qHesQAQTppqVTd
X-Received: by 2002:a05:693c:83c3:10b0:367:185e:867a with SMTP id
 5a478bee46e88-369d98e5b8cmr1177165eec.38.1792720272443; 
 Thu, 22 Oct 2026 18:51:12 -0700 (PDT)
X-Received: by 2002:a05:693c:83c3:10b0:367:185e:867a with SMTP id
 5a478bee46e88-369d98e5b8cmr1177135eec.38.1792720271924; 
 Thu, 22 Oct 2026 18:51:11 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d5fadbsm1948565eec.8.2026.10.22.18.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 18:51:11 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 17/43] target/hexagon: fix semihosting OPEN filename handling
Date: Thu, 22 Oct 2026 18:50:14 -0700
Message-Id: <20261023015040.2473105-18-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
References: <20261023015040.2473105-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfX8AlHILxSfYbz
 A0Zc1BDZjLjGLm1xPOhhsd5+xyWkhlHbmU1tUtKF2/+vLRLjJ+7YaqTnmrkH9vDmRmS4YVS32er
 zXQzXBCu6PeFewp5On/0ex4Q4GG37FrS8PCvUkc5VrtLBfADnkQUJF19VE3ktCSp6g1VN8Orik7
 Z6SaajHWXTIY4ZxTSsPpx1Vid/Oz+STpLBP//+jUhwCabXRKnDPUxpsoYFlOX8fxGshiOGct1S1
 ReHFlHrQxpeUb2sQjbZhAg7r/R3+dSf44M5TCxIbU65dxqKEJGRyzICCKnYCMr7Yz9ZCzGdq5TS
 kdaB3bzbyBnivsqKf5N8W/xoXo8o9Mf2puEZ/mDju8HQhfejKDTZflTKhieN6l4GReQX7ptIGXG
 tzCGWe9XGD7YuqZ2NCIGWtwKDChLnOYgxJ9HiT/NZZrUBcyzUE4i/uSFZfmwahG2B/1DeSfl5+C
 RBZ9WlQb+22m7NGeZ+Q==
X-Proofpoint-GUID: o8kXhTK40-hvhypWQjG8bFTiF4V-eN53
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAwNyBTYWx0ZWRfXzzkxPts0smRh
 ItBXBFeADKDaDmzzr6HFfivUaJDXV7puHrsYQXiGp4lm3p6jT9LHhmKPv6V7djWqZ3PycC4hQDn
 oq8weDzko8qdZ7WlDerrt/fbfWePfC0=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6adabd91 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=wfIhpZVs-6LWPqknoVUA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: o8kXhTK40-hvhypWQjG8bFTiF4V-eN53
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230007
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
ZXhhZ29uL2hleHN3aS5jCmluZGV4IDg0Yzc3NDA5MWI1Li4wYmUxYzEzMDFlNyAxMDA2NDQKLS0t
IGEvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMK
QEAgLTQ3MywzNSArNDczLDI5IEBAIHN0YXRpYyB2b2lkIHNpbV9oYW5kbGVfdHJhcDAoQ1BVSGV4
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
ZmlsZW1vZGVdOwpAQCAtNTA5LDYgKzUwMyw3IEBAIHN0YXRpYyB2b2lkIHNpbV9oYW5kbGVfdHJh
cDAoQ1BVSGV4YWdvblN0YXRlICplbnYpCiAgICAgICAgICAgICBxZW11X2xvZ19tYXNrKExPR19H
VUVTVF9FUlJPUiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgIiVzOiBpbnZhbGlkIE9QRU4g
bW9kZTogJXVcbiIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBmaWxlbW9k
ZSk7CisgICAgICAgICAgICB1bmxvY2tfdXNlcihmaWxlbmFtZSwgcGh5c2ljYWxfZmlsZW5hbWVf
YWRkciwgMCk7CiAgICAgICAgICAgICBzZW1pX2NiKGNzLCAtMSwgRUlOVkFMKTsKICAgICAgICAg
ICAgIGJyZWFrOwogICAgICAgICB9CkBAIC01MjgsNiArNTIzLDcgQEAgc3RhdGljIHZvaWQgc2lt
X2hhbmRsZV90cmFwMChDUFVIZXhhZ29uU3RhdGUgKmVudikKICAgICAgICAgICAgICAgICByZXQg
PSBndWVzdGZkOwogICAgICAgICAgICAgfQogICAgICAgICB9CisgICAgICAgIHVubG9ja191c2Vy
KGZpbGVuYW1lLCBwaHlzaWNhbF9maWxlbmFtZV9hZGRyLCAwKTsKICAgICAgICAgc2VtaV9jYihj
cywgcmV0LCBlcnIpOwogICAgIH0KICAgICBicmVhazsKLS0gCjIuMzQuMQoK

