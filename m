Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B471606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QeJq+Cxc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BLd+K4ul
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWIzK-0003iJ-HJ; Wed, 25 Nov 2026 14:49:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xWIzI-0003hx-Hs
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:49:04 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xWIzG-0006Kv-NF
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:49:04 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6APJgk5E1138127
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 19:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LkT+jFR7bC3qnIIb3kv+jB2JPZnwZW7I8SmHY3UmzvM=; b=QeJq+Cxc3hqNtHZ9
 zd1CDG86pq1KAW8pPb32d4QoPtPf9zOWVXeRC+1nxHT1wf6ASm3ezCq/wjDOb1ok
 D3vwRzSgRV7+mRSs2NAjRIebL4BdR+611XG4p5okwTf6zxoW6siM6vNA3/QU5CYZ
 NpITjrSl7DF0dXErMDSBWaTHmclAnXgAwA4nIb9mVHci5eTGNDUVC4f/hWgTDHd0
 3hBzy00szPOXA66Lu85f/XpINpy3CEP8qIR88lyFYKsFiF8OICG9ekpqpQyEPlUb
 /TZtHA37akVpVpx+C7CJ79Z9RPffuOsDCfQo0GKzbPzwexkEe3cEq4/yGQ4OFDvQ
 AolTlg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j662s80n7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 19:49:00 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1b587ffea77so643382c88.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 11:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795636140; x=1796240940; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LkT+jFR7bC3qnIIb3kv+jB2JPZnwZW7I8SmHY3UmzvM=;
 b=BLd+K4ulJQ7CAQvHNH53n2l32fQ/f4JB3m1/b889Bjh1P+8U9wc+KYARLJDggCtKah
 oKHnlWVZbERPChrw+FmECnZREiyZpRnb3BILrkGRuBbZaPL1plCany9WPd9iZNqQYXdx
 iQo0oMMNT6IXeXmhhOqtZK0iLhaCK6OBDot9r24GjjGBleQ1u+lsyqLBooHbvds7EwIp
 wyqmfu5HusefQcIk88X2eTapeOpqG0YwbiHNidJlCNqzzH0sqS15xKSUv0wwCps269vB
 GHAoxPYgSkU32RB+hTn65bUDuiq3sgUNlItp8s8iSCEbMAIQ9d7VA8jZuUguzVYCjatf
 WYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795636140; x=1796240940;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LkT+jFR7bC3qnIIb3kv+jB2JPZnwZW7I8SmHY3UmzvM=;
 b=Xacf21GcQlK490/CaqKi3yrZSsx3+NA2mJiTgsZU6skXng11ULw0aFfU4seeEEcWVX
 ctZD0ArZohcgwCjU4uooMllSv8eqt8L7ltts4FnHBv1qm3BznikslcwOqzeXYyKzibbS
 G1t3uXaOelzQPea91un+MVyDo+jQ1nI/1mP5uilIQF0hCB/mZgzBsnvgNGHUAiipOXPQ
 aKmJYviEHLCrcg4wOqn0fI+njkc6xeCk+c8uGdRvPusN6aaM8PTC1Jy8LZ8fWu7jPvgc
 YxwknNYJROLsiCTGYlT8CcTk400cnU2vN6umHUjwED7cRsxOV282NwOFda63W9XdLoc7
 XL0w==
X-Gm-Message-State: APuU4Z/iabXCZlYb/UjQDDdaesETOyUOB4v2/ulL90ag9T+PUBzA2lB3
 j90mnuqD4xN9/swKBM4fACmq1eX8OXZtVg0Brg1P+BFpQ1qprxXm2qbVuoEFWZDgBx3ZByp46n8
 NLCKCm7NF/KXT9lFMdlBZa85+e4Pv5hjgfpwZXjKYjVOrffW+xluNY4r9hsQzPwVemg==
X-Gm-Gg: AZFdTZdJmHXPfjYqUdPwGDyNGdSb/RJHuguaXdwEdxgkmjYkr98yp6uP14TmrQLobYK
 05U8hSpcv3GpsYbfNjTMa8dA3FN1KABg4trRc2nrrZHY6sl4h9twGTOGFO+CVe5af0bDNSjoTE9
 vgofnBujtV/swRjD0rL7iPsi2ZCuqr3s32idY5EDzbby9EHc0kJcY8lW67BgLt6Q4HFfcxSBivy
 3r+FLGFTkd2zKsmGUpx9JHQRK9VREHJGTAkAfkM7zK8g3iBok6/7qMwa/iMRMb2HojFJI7Nvbcr
 KwPfkXIA8Jv6Hb8NlExaPgHYx78Kceuqg2D1sWk0+K+JhoxZQ+Nsps3F35zk71E099dntbmb+dT
 3vbLTO08MjarcRy4PgwYn99TK+Y4K/HEAgPIPuLq+StRagYWHMlGeFZXf/5197lwcMRdH/QCIPQ
 G59khMtcaM6f7BeiJYbqVCDg==
X-Received: by 2002:a05:7022:906:b0:1a4:c892:b14f with SMTP id
 a92af1059eb24-1b556904c50mr24669483c88.29.1795636139611; 
 Wed, 25 Nov 2026 11:48:59 -0800 (PST)
X-Received: by 2002:a05:7022:906:b0:1a4:c892:b14f with SMTP id
 a92af1059eb24-1b556904c50mr24669464c88.29.1795636139117; 
 Wed, 25 Nov 2026 11:48:59 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b556840494sm44407715c88.12.2026.11.25.11.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 11:48:58 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH for-12.0 1/5] dump: fix e_ehsize in ELF core headers
Date: Wed, 25 Nov 2026 11:48:51 -0800
Message-Id: <20261125194855.3154845-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125194855.3154845-1-brian.cain@oss.qualcomm.com>
References: <20261125194855.3154845-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=B54sQ+tM c=1 sm=1 tr=0 ts=6b073bac cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=YYXFeDNx8urxxFB-_bQA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: 2xTolzVb9P_zosVJ0Ayh91jylJUpBTCL
X-Proofpoint-ORIG-GUID: 2xTolzVb9P_zosVJ0Ayh91jylJUpBTCL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA3OCBTYWx0ZWRfX8QIQ0UsaeN9X
 X584GWduZNytXqkHoN8M902WjfGfooU9KwsuMCd/QJLWUgazdjf3XycXk8Mxtz/VYbGAitayT5J
 cHe+RnYm7jucEBzA1696asC1R1kanQsPcz1MA6bV4imnltBBELwVaVoHKiKpSwHPgMgw0+ZyS2A
 fij4X2eswUGu1K2TFJUuZfisey6V74rnt/B3JHpvt45QIrT5EHc/I/0UAziIyPlOv/q4s7lp5wC
 oTQyCa1J1VGLuGoqLyH6D0W7ErjCupD095mWZNfgH1hOEarWp1B7rGF4s4WsIkjySuSAcB9CW40
 xTAmRtsrvrJaWjWJngkqv5/UEAPftHoWfqpUjax3C0XTLvBxQtlHzjyYdSvics7DNDVCeYslkDh
 31ZWUVVnEeQAGlLx8n9/UGdxqVO3jrgc16v3lXlIyQfIUhNTrFmiJRqglNFvzYmXXutXGNUM3Hd
 Y9rnB7mzUtY2KDNLDVQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA3OCBTYWx0ZWRfX0cp+L7aqySY9
 RVPUrSQhOOCWUv4iybD0qWAF53t8oiSt/T0Qt1s+F5AGniSSd/BLxks19/7Vi1eAAxlS7Sfzc4y
 wRuWERtmfXXzJ+UJa6OmtGYLqJTZuzw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_05,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250078
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

cHJlcGFyZV9lbGZ7MzIsNjR9X2hlYWRlcigpIHVzZWQgdGhlIHdyb25nIHNpemUgZm9yIHRoZSBl
bGZfaGVhZGVyLgoKZV9laHNpemUgZmllbGQgcmVhZHMgOCBvbiBhIHR5cGljYWwgaG9zdCBpbnN0
ZWFkIG9mIDUyLzY0IGZvciBFTEYzMiw2NC4KClVzZSBzaXplb2YoKmVsZl9oZWFkZXIpIGluc3Rl
YWQuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5j
b20+Ci0tLQogZHVtcC9kdW1wLmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHVtcC9kdW1wLmMgYi9kdW1wL2R1
bXAuYwppbmRleCAyM2FjNjg5OTA3YS4uNmI1Njg1MTY5NjAgMTAwNjQ0Ci0tLSBhL2R1bXAvZHVt
cC5jCisrKyBiL2R1bXAvZHVtcC5jCkBAIC0xNTcsNyArMTU3LDcgQEAgc3RhdGljIHZvaWQgcHJl
cGFyZV9lbGY2NF9oZWFkZXIoRHVtcFN0YXRlICpzLCBFbGY2NF9FaGRyICplbGZfaGVhZGVyKQog
ICAgIGVsZl9oZWFkZXItPmVfdHlwZSA9IGNwdV90b19kdW1wMTYocywgRVRfQ09SRSk7CiAgICAg
ZWxmX2hlYWRlci0+ZV9tYWNoaW5lID0gY3B1X3RvX2R1bXAxNihzLCBzLT5kdW1wX2luZm8uZF9t
YWNoaW5lKTsKICAgICBlbGZfaGVhZGVyLT5lX3ZlcnNpb24gPSBjcHVfdG9fZHVtcDMyKHMsIEVW
X0NVUlJFTlQpOwotICAgIGVsZl9oZWFkZXItPmVfZWhzaXplID0gY3B1X3RvX2R1bXAxNihzLCBz
aXplb2YoZWxmX2hlYWRlcikpOworICAgIGVsZl9oZWFkZXItPmVfZWhzaXplID0gY3B1X3RvX2R1
bXAxNihzLCBzaXplb2YoKmVsZl9oZWFkZXIpKTsKICAgICBlbGZfaGVhZGVyLT5lX3Bob2ZmID0g
Y3B1X3RvX2R1bXA2NChzLCBzLT5waGRyX29mZnNldCk7CiAgICAgZWxmX2hlYWRlci0+ZV9waGVu
dHNpemUgPSBjcHVfdG9fZHVtcDE2KHMsIHNpemVvZihFbGY2NF9QaGRyKSk7CiAgICAgZWxmX2hl
YWRlci0+ZV9waG51bSA9IGNwdV90b19kdW1wMTYocywgcGhudW0pOwpAQCAtMTg0LDcgKzE4NCw3
IEBAIHN0YXRpYyB2b2lkIHByZXBhcmVfZWxmMzJfaGVhZGVyKER1bXBTdGF0ZSAqcywgRWxmMzJf
RWhkciAqZWxmX2hlYWRlcikKICAgICBlbGZfaGVhZGVyLT5lX3R5cGUgPSBjcHVfdG9fZHVtcDE2
KHMsIEVUX0NPUkUpOwogICAgIGVsZl9oZWFkZXItPmVfbWFjaGluZSA9IGNwdV90b19kdW1wMTYo
cywgcy0+ZHVtcF9pbmZvLmRfbWFjaGluZSk7CiAgICAgZWxmX2hlYWRlci0+ZV92ZXJzaW9uID0g
Y3B1X3RvX2R1bXAzMihzLCBFVl9DVVJSRU5UKTsKLSAgICBlbGZfaGVhZGVyLT5lX2Voc2l6ZSA9
IGNwdV90b19kdW1wMTYocywgc2l6ZW9mKGVsZl9oZWFkZXIpKTsKKyAgICBlbGZfaGVhZGVyLT5l
X2Voc2l6ZSA9IGNwdV90b19kdW1wMTYocywgc2l6ZW9mKCplbGZfaGVhZGVyKSk7CiAgICAgZWxm
X2hlYWRlci0+ZV9waG9mZiA9IGNwdV90b19kdW1wMzIocywgcy0+cGhkcl9vZmZzZXQpOwogICAg
IGVsZl9oZWFkZXItPmVfcGhlbnRzaXplID0gY3B1X3RvX2R1bXAxNihzLCBzaXplb2YoRWxmMzJf
UGhkcikpOwogICAgIGVsZl9oZWFkZXItPmVfcGhudW0gPSBjcHVfdG9fZHVtcDE2KHMsIHBobnVt
KTsKLS0gCjIuMzQuMQoK

