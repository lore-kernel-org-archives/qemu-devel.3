Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871D7606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iKBt+Sbs;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eKclsURT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIuu8-0003Am-0F; Mon, 19 Oct 2026 17:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutE-0002kb-Fc
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIusx-0006JI-2e
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:15 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJK7Yg2604970
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VvYfN+AguCkl+G6ppy0+7XyP1jaMaH4zlIH6AcmdFD0=; b=iKBt+SbswF72akCz
 l4naGBIlMtaNrJGXGx0+pSAoimlekB9QMjYOH7ursmGD0Z5iOe7sJeyl4p/48gcX
 u60rqORKzPsUQU146TjThjDmRWGT0FyEJPOes1z233wnCGcCB/U9aFEnM5N8hqOm
 NeOrs1KZlQPknTwWIOnV9Qor/6ySA67mjqEdsatIyLbC7saq6jXhOcp4r1eLBxQo
 1DgzDToECRlPBdY0A2ODnZ0iXj1z5jE0spvg3XZgRdo0c8QY6/4WnJnJm5bUoNY8
 lRBoG2GBXiGU5Wm5wxYgBXNd2UHEImtgzZ4PJ8glEYPOEBEu15MDWPnaeJNjfMXH
 /QBhlQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr4a0q9u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:09 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ad436a9d00so1188038a91.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445229; x=1793050029; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VvYfN+AguCkl+G6ppy0+7XyP1jaMaH4zlIH6AcmdFD0=;
 b=eKclsURT0lyoCMGAJcqw5yEcX09B1+uTDCJ1ofpMQtQUiu9nHXHOen/u+u6VHyyD8y
 0RW/twdj6A/kaFF8N+Lk6y6WC83mRF63l8j+oADLZ5mP3eGBPBHYL+GmXa//B0Ka7qhC
 S8DumwEEDpwQPa/1dkwZOueHi7AfPgI96Bcf1G1xafbMmwnudBlUQWjXCOe39smFELUm
 4UgHpGQ5L5ZAFMPzZ3hnO3Q8bpFPfJkq2CrRw3OHZ853r+Il9BHfaEGg49yfO2VeVF2H
 ByK6Ll5h4OD6DqscX+8g89hRB5Zz5Gne9EZEzlLkJOhXgypm4hyg+8CRxddm5VBrA+K/
 JgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445229; x=1793050029;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VvYfN+AguCkl+G6ppy0+7XyP1jaMaH4zlIH6AcmdFD0=;
 b=eQ+QPbbA1FCwIDbeWjuX9EV4Er14ywUxg4z4sKdDBwdHYOY9q4gFAep9VSml8x5oxB
 H89KexEB+L2WDDQHoq5Q5Qbea4X34OL838NVgf28KU3PsDKc2mQFuZUgQEQudpk5EI7l
 ti3bOHBmTWxPfuGKThuFVdf143uoSfxrSXsYD+vF6NyTpLzeiZMLX1JdX0kfmqcz1HwH
 LOUKgPh1yp47YCU5/BySLUeMkuFOZ9/llEw/IGr02Q2KDTEVW9S4soebH6e8S6kJv9VU
 4UcXLnbz71ZZ1RpScp7rJOSoxriQkMROTISJ1bIYwVPAdhZb+GSTxn6RAjjQa338cZim
 BuYg==
X-Gm-Message-State: AFq9FYJ0OXbrXf2mfkc2UtiQe9M4/+3gjEHq+wvqtkdgnCjpvy3RDV0I
 7S3W3Z4U3nHJiUvEoxdWOgbib68YJqPpG1ilMH9x3vJ2Z6Gki8a7GGRmZZ4Je0drwMMxILP9xlX
 2ZMlUOIEVDg2rwgMpEs8Ay0mDuCCz/xRPw3k4M3FG5byn57u5ZkXoTyzS/x3GDvHC2A==
X-Gm-Gg: AYBFou0A+E0WUnXSDNwv+8wOx6xvqFmZMsnJ8c9Q8X3IdaWUQumSuSCS1eGjzRZBu/p
 S/YiTpFp6qf4flNuuDmqReXLrY3Fu83FNGL0s1noNbD/PK8rXepoEYw3530BxBvlfwK+Na3Ijnl
 h5ee5+NDa1UrEwPQl/5zqQAJzhnFvGyTxyQt/QY65XBw/NEMwg5M5fRp+pfRMWwP0toQStyt4DM
 r7KghcxA6wFpDjORvjdIlYPUR1yl5sudxw/oW78GOVj1VDMqPhazamwngzkMMo1m9wzCkDEb4qH
 OQ6PDkazsTcqaV3Q0O5FCoQmpKHTiftNsr1vmbqNZ6Ynv8YC3ZK2VFPwGolobn1QHLzc6x8F3Mx
 7xRz+zC/96bzPirBZSscd21smKRPjLlkCxlD81JKZKbyGIHUP+g08jfBYN/auXPI=
X-Received: by 2002:a17:90b:5111:b0:3a8:7096:9b48 with SMTP id
 98e67ed59e1d1-3acee293889mr8301873a91.1.1792445228577; 
 Mon, 19 Oct 2026 14:27:08 -0700 (PDT)
X-Received: by 2002:a17:90b:5111:b0:3a8:7096:9b48 with SMTP id
 98e67ed59e1d1-3acee293889mr8301859a91.1.1792445228142; 
 Mon, 19 Oct 2026 14:27:08 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60f2c785sm867061a91.7.2026.10.19.14.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:27:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 04/21] include/qemu/typedefs: add GuestPhysBlockList
Date: Mon, 19 Oct 2026 21:26:31 +0000
Message-ID: <20261019212648.154493-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX9rcSg5MxqA38
 Tz0viNE8vfj5pRqekIi6x39bR/AlFQMrs14uYHiZ7NW0vD+1t5KRt5mqBtb4x2KeEeRSHYsqYEp
 2kX0lqn4mwgeFmEk1LEGVD3IMx9VYBg=
X-Authority-Analysis: v=2.4 cv=Zt54uN7G c=1 sm=1 tr=0 ts=6ad68b2d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=s3Zp9V8Yp8F-_W0-f1wA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: bc5-FYLxJiq4bHkVxVE3S8BVFiqyjV0J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfXz8U0mA67j73W
 FPdNdZoyYEXYWypQKknd6AAgjzZIWVnUcwWg1DuWEdKhkb+VplaWVuSn5qVn48JwFaMVdrnpCO6
 MDCv8IbtEhI3pwy0hi5aeSBi9UKwNC/t10xKKHHKl2LIioZoXQp7h6KD5EHbgjNqXEB7q4+Hze7
 84SIBc2SrSKNMDttXYPz0RnA1OxIkvOdbyAJMzOS3ADzDpHljdOmibfDlAK8DEfw98EaQfHomZH
 I67/hO2tbRrgg/pYScT83MB+DlM2KcqigsEbLDoxiDLntK01/N561wxvtkjKc2M+qYQq62Lk2+k
 xCdHeCnSgwXpI1ERwEHgb6nz92XyacR3BJAuo3Hh36LjUI3gY/WyxaXIwO0dyXzmqWL/cgBoPhk
 IyLRaavFQ9ELrSReIJhGqh4BGkt9PwrUxrehQAax/twcIIDtRdh8A5lmQBjdFZ+TIIfwptjxD4p
 ViDc1S3ZmJOCR/VCkuQ==
X-Proofpoint-GUID: bc5-FYLxJiq4bHkVxVE3S8BVFiqyjV0J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190085
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

This allows to use a forward declaration instead of including
system/memory_mapping.h.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/typedefs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 8fa7f752dac..488d2556670 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -53,6 +53,7 @@ typedef struct Error Error;
 typedef struct EventNotifier EventNotifier;
 typedef struct FlatView FlatView;
 typedef struct FWCfgState FWCfgState;
+typedef struct GuestPhysBlockList GuestPhysBlockList;
 typedef struct HostMemoryBackend HostMemoryBackend;
 typedef struct I2CBus I2CBus;
 typedef struct I2SCodec I2SCodec;
-- 
2.43.0


