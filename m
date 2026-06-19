Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37BDCD98E6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 07:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waTQs-0007FT-Si; Fri, 19 Jun 2026 03:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waTQr-0007F7-BB
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 03:14:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waTQp-0003HU-Ji
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 03:14:28 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65J2u3jx3701725
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 07:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=R2lAKmqotaPrQBXsGWcZLc
 CCm7JATvZZ9xxaq4Wlh8I=; b=pn5VI1+HdrPGMNjcBSh8+13kAD2+evekQv8QfD
 iT6bg+ceJaRTkTks5neFramxGXvDXt9L2Gb9Vv8ipSdeYpECuuEXABg4xHl1mncz
 Mt7xWND4nC6lEiM9ajlEkde4Ll/iUf4CRzooIzq32MVbNgrfIEqEHJQ/kBdNJr++
 hKteyi1eydN8uPRZlNu6iABmWBN/xeGLT41OAFsUKT69Wghrf3S4t+8rqz2WqQA6
 l7lreBZbDCLqOsACfDPIsmnDZn/TdVfnME1W4yhO3Uxqt/BG7a6n0YklYEbMaCKK
 yzj5cM2htCVmgbok/45i22ytQmXK/Je9BvyCw+Z8cjjbmASA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evmtjap1d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 07:14:25 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9208aab5133so109795485a.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 00:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781853265; x=1782458065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R2lAKmqotaPrQBXsGWcZLcCCm7JATvZZ9xxaq4Wlh8I=;
 b=WD9qVMzrkbpbeFBc/xXpOFS8RNzUP1EOw7q1JQ5vRwRLnpurN86c7eb5AuGICdov3q
 Xf52Lyi1LgZyX52ra5xiWJIcznCMIiIh5uVWrt7xUICyXO+zYn3eWA70Z9otQAnw3797
 k/Gy1sKz8bWaAL7CbzCxxcxqYtgq15PD0oCEnvow05Bpj9CwueBx0p7G+NpnNbca1kql
 qszh+PBk1ZFRDKOpY7l4nZ32jdNgbQvTwI8opmAoylD0SUjkyDVyifKmOncvDDMoxCsD
 YRFF00eK+2b/GGL+JmGNH95pfEVJJ/cMMlWioxwkB5CaR1+k3MkCKBqMtsojyhEy5xki
 rGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781853265; x=1782458065;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2lAKmqotaPrQBXsGWcZLcCCm7JATvZZ9xxaq4Wlh8I=;
 b=bjrrSVC4n5FaC/NzT/geeaCal8d6nI59ZPce70WnR1M/xenX2U4aJ6HaiKDU8vDaMF
 yy1gD77j38lI/kUj9t2k/qUqR/fsdJKMJU9JGl4Yp7ObYHOT9bO7wvM/2hCBIJiCjROA
 4zVi3olpoXxqrJiG9n4LuKN3WUNMoFYLXo21Rs+607FnZB4ZB7hoHBGQRB7AJtuxgUe/
 RubZNL4CKcjxhjlhtsct+UVrRHD7atIQkWn8MENhpzEoQMZpXN/Rq7cwwmzlfbaMTKNU
 UZ0in9vUe1J7DhDO8H5yYiKsRlsaveNSYIlSRNNbZzBw0yIdXFSG5xnHjtWPeuqcBRIM
 HZzA==
X-Gm-Message-State: AOJu0YyVgaRrqOpPJ/3l0FtTlTxjQsRqunrvfm2AVA/Gr9jQJQvbVqFX
 PXCQ9LNA0dK9GE3QICM08zM0xj5HlobMUPWldEZzfLOVFG8Gu6qQkGZ66yF+w5dEn+1G/8QBiR7
 SpMNo3GgTGIcoJHA8lTQxyIIPm8v0bOdaS9z66xNUaUeBHL5nsrp0v/C6UKwk2CWxEw==
X-Gm-Gg: AfdE7ck7Xg7Xl72po/3idbQmcvaO4g/ZGHbG7GXpa0AxN3NwYL8H0w79qF0+6ah1fgj
 XWBjqb9Xz1Ixi7FbH/bsM+gXgF1Sy2wv2SOdGl+JbbqIKSc8vKPPMZiF7zwI5CRxWrbzpmlgBhz
 8dB7ap9WfQoEBcN3y3Yz9tI5UzK8jwzW8A27sI+mfHlcPviiprsRFdy04GYPLAFIyFRIj2Xd0Br
 nR2UzQBfrgIThvKcYZQGcyN60Ia6G5IjyKYXqVXUj2cS5D+5wXaZxQVCMQ0s7jtxfG5kInF+k/O
 PITEQ8sVvZ8Ybz4PWtELepp8RpTAv9HYDzAr9YrYrzL0jhCE2Cz25JM7YnpP9/CDYfx485axEwV
 cyM9vLnL2FZGxxLYC/p6jXPxEcbQhMe6MtC3f8CWMO8Q45HFKgwY08SzVfXZStK8qhJ5c
X-Received: by 2002:a05:620a:2725:b0:915:9e84:85d1 with SMTP id
 af79cd13be357-920d1af5f05mr189400385a.23.1781853265176; 
 Fri, 19 Jun 2026 00:14:25 -0700 (PDT)
X-Received: by 2002:a05:620a:2725:b0:915:9e84:85d1 with SMTP id
 af79cd13be357-920d1af5f05mr189397285a.23.1781853264719; 
 Fri, 19 Jun 2026 00:14:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fd164f5sm45662755e9.11.2026.06.19.00.14.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jun 2026 00:14:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Ryan Zhang <ryan.zhang@nxp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] mailmap: Fix Ryan Zhang email address
Date: Fri, 19 Jun 2026 09:14:22 +0200
Message-ID: <20260619071422.99061-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA2NSBTYWx0ZWRfX8igLms5yiLUc
 pB2PdT8I6bqQEFO8w5SXWgbXEj1oubUYNC5VeD7WeeMuzhxzHKtKGfZ2nGW6M2Sfa83wopr6XG1
 dt3yyM/yFHvQl2fqqMwXSHWkZxGy/FY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA2NSBTYWx0ZWRfX6YF8pqT/TpZV
 26Y4vhSlyZUGyp350e01z+XgEeUESjX+zlDGPqJ8IoSf3FSkPoyH2MgyJZm85wkV4fnrcSjVgfO
 mNdFzIB6w3UDzLSwdnyAag0kVy6FZXJkVEQs4tUZOE6T1OoJI3blq8wTOUwq192jnPoy4VzAT5L
 l9azP4/LYuzU1YOMoHRSzDFEPX7bikNde2Y/Yu7MQD7jiUbx6Qv67ZZMog6pWj65srIjQTCFLmB
 vkz8jOZB+ibowEF41k7b2DuSiFPqbwPbMy75f1zIPpU4h+db2cFf1+F3ZyFiCf3h+q4wXvoIQf8
 giBodiz09NnvrR7VQw7y9pxXsbX4lH9dPv9PKW+jd0PeIRy26T/HfUCLWSC6hhOrCEmSDSxmt1E
 Q8mIHMULDm8Aw94V20AhyDqCx7ph0JhnNNCJhzoGtgsVBAubf0dkhwazO+dw4GkU1FCjrs+jq3v
 MM/Rlx7BDt6HbDTPJlw==
X-Proofpoint-GUID: 4a3j1BUvqUgzHQimMLPDeUckR9YXxbQp
X-Proofpoint-ORIG-GUID: 4a3j1BUvqUgzHQimMLPDeUckR9YXxbQp
X-Authority-Analysis: v=2.4 cv=OM8XGyaB c=1 sm=1 tr=0 ts=6a34ec51 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=voM4FWlXAAAA:8
 a=eh1Yez-EAAAA:8 a=8AirrxEcAAAA:8 a=pGLkceISAAAA:8 a=Ju7jMt4ktShZWy1-wWQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=IC2XNlieTeVoXbcui8wp:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190065
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Add a .mailmap entry to fix the invalid email introduced
in commit 490a3e1867f ("ui/sdl2: Set GL ES profile before
creating initial GL context").

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 34c092714a2..120403aee00 100644
--- a/.mailmap
+++ b/.mailmap
@@ -35,6 +35,7 @@ Jason Wang <jasowang@redhat.com> Jason Wang <jasowang>
 Marek Dolata <mkdolata@us.ibm.com> mkdolata@us.ibm.com <mkdolata@us.ibm.com>
 Michael Ellerman <mpe@ellerman.id.au> michael@ozlabs.org <michael@ozlabs.org>
 Nick Hudson <hnick@vmware.com> hnick@vmware.com <hnick@vmware.com>
+Ryan Zhang <ryan.zhang@nxp.com> Ryan Zhang <mailto>
 Timothée Cocault <timothee.cocault@gmail.com> timothee.cocault@gmail.com <timothee.cocault@gmail.com>
 Stefan Weil <sw@weilnetz.de> <weil@mail.berlios.de>
 Stefan Weil <sw@weilnetz.de> Stefan Weil <stefan@kiwi.(none)>
-- 
2.53.0


