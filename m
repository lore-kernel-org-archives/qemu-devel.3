Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441E7606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aeXZMlDX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FjlVtsll
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIutd-0002wY-EX; Mon, 19 Oct 2026 17:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutE-0002kd-G7
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIusu-0006It-He
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:11 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJK0OK3328401
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VwD3VnWYsutPvkh+7HGv1QSNlTS7u3OJNDOTErxPLRg=; b=aeXZMlDXTK8g/UDK
 +k2E4obcgfJrcVr3TpxjbTcZzUiBnEQipFbD6zqLDrPuSRSFx6oju7V5RjyEDEKo
 hf0R0nPvC7g+ZXfq1T0bQdlAzqx9EiAzYvsOOTJbe2cxZvEx/D3miVHGY1vMf477
 L20GGqbCcR9AVSh6KIjmwnuMTf9D16TdzkEItREWOdYdsmKiEOaOlj3bdGlM5ZIs
 UJhr9przimjGuLlczU66mh4hT8He+rTUjm/qVDwU7F8rozPXH4UM4wGkVKIMJEao
 x3+Nmzdxi0VFkzi5/yQCylgwNNNlLrpeLHoZPt0tCmFr7N8E85DAmpMChfajORI6
 35qHyg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdkmfj34x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:07 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab1e771632so83816a91.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445226; x=1793050026; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VwD3VnWYsutPvkh+7HGv1QSNlTS7u3OJNDOTErxPLRg=;
 b=FjlVtsllqglvmDrYTmMjxyx3HS+yIuGiV9u+iUPMPuFeJYXSUwv1YMIsARZIPzaLxL
 6fMklUcYIuK+Xd6ET9drVVwGLB2ofDBpa7CkuO9wSMjmmYgl0l28ZAR2FvHF28XvlzN6
 GbbhziqZIB1lm/PD5DoWXOmtTDxiFn0vb69OZnuno8FW+AvaI1ed0pV51vFrIjpD6akb
 tLDVIIXpBgpxr6C/TgAoFOdAAqPc5uB6F8DF+3XBk65nF/S00P50xsk0idgfmKVtWK3V
 ZVJS4u7Dmi/+W2z0W8mJIXPg9REmZraucDDftaz7OhAsngTFl+YcBlVaJFJw2Di6ZLLK
 FfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445226; x=1793050026;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VwD3VnWYsutPvkh+7HGv1QSNlTS7u3OJNDOTErxPLRg=;
 b=nwUo/o0Dp29lwWXPxOnCZN+PMGQgtoIkjzO384rWSgK8XPTR4GTuSDscBWkMcjc8sL
 RfiDfyzhRCBclolDox6Ehw1TouRXlhbX0toMfkH8NALGPFvLvAWjF9IEUtgzvefuaku7
 8t6zFige9luz2Oj3nTH9nXafwdfgqUrg34bv24Zuj6uo4hqExOAa4vpyFsEnm6Jtf+RT
 0eTnHbxXMCgU5M78iSL8O32HAg0/XCu6zWitKhgHdvNJp6f2z1/gw7mL7TPQOytNcyqI
 iPYazbnUtcKCJQXfEO2liG6VVsV+h9d/cV7f593CUmLSuMcP74eggYIGgETffI+GJkpl
 Ykdw==
X-Gm-Message-State: AFq9FYKQXRWKElnmSLrpWBWxvJC3jkm8yKZnefHHWBtbzdxPk2s/qp3w
 uGHKKinEqPYuvrKfg7eLJcPmHXo6MWOv+eqiPp+KhWkHuOBnoKApRN6xlTzwId3O88jp1OpNVpL
 GY8I+Y9az0svqduCcyireH37TpTPyEMakIuqLkv7DWygMn0m/gwhU5qxIhk/1qiFjLw==
X-Gm-Gg: AYBFou1zXkwTLV50e8e8/x9a1s01fapX9zHTNwQuVVHpxdNmQeIXjDA9xjJAZIbZ3mD
 xssrzHod2fSXTRzVwvzijr0iC74/h7RE0uo8YJyfcCgo1+vgpyEvJ7Cs3Kw/wacC4AoZUTEcSuS
 diP4SDs10jhPbKM4t47gJHK2GLP8qhh0pQ6bCtQ8jw+wU/rn/7pKWiDQRQEKxK0ooD6p914oZC1
 IRjiEGWUd8gRffg21wg0KqB39m5r1M6dvf2C/sE8nj3WXkuAxwnaIud+wlqIQydnha1C6tOOJji
 M1g+/IvxaDYlJ6JdFtsQSKNdlZY9cBexhQRtzyUIwCGprszHsaaWWPBDO9u9WvUKdXoynv7UXKe
 h6lAfRB1RzgIns+96qvZXCU3rXd6Fbaesw0n4SCsxAoHenaMuIHH2cZqYFNYwtIo=
X-Received: by 2002:a17:90b:4c4d:b0:3a7:96d:feaf with SMTP id
 98e67ed59e1d1-3ad64ba653dmr187588a91.16.1792445226142; 
 Mon, 19 Oct 2026 14:27:06 -0700 (PDT)
X-Received: by 2002:a17:90b:4c4d:b0:3a7:96d:feaf with SMTP id
 98e67ed59e1d1-3ad64ba653dmr187578a91.16.1792445225705; 
 Mon, 19 Oct 2026 14:27:05 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60f2c785sm867061a91.7.2026.10.19.14.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:27:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 01/21] target-info: add target_heterogeneous
Date: Mon, 19 Oct 2026 21:26:28 +0000
Message-ID: <20261019212648.154493-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NjGHWs7HPMXsheYxoAOK5eaLnU5c-8e4
X-Authority-Analysis: v=2.4 cv=O+isLx9W c=1 sm=1 tr=0 ts=6ad68b2b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=gWBptB01sUyPCzWYWEIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX4gtcrszwOMg+
 c0FqZ2xqbSroa7x6n2mfWSWkYpAwiybFO1AC4gwAEVxGfFKmmLQZ8TMKYtTE39rmeYAIpnT4Dve
 PE6T8/0GR5C339ZJBin5pfjxZdZ+Q91uH+Szu3o5nab6T2muCDzSMYDKGdoQsxvoqicJzYzEZ5p
 Xz/GeQYOljsFcUpaD9z8JX8GWcxoPqa7XAjrrTz9+T6RDBEUVOGO2uCMrDG072K+8Pvco8mM/2C
 4UfC/2mUs2ieu+uJMzS15fF2BneGT6gJ1N4mVXHxHbFPrpzor6HIfn4XVea/+LM4EXDV0NIktcw
 JPyro8YYgzvbOnthhTogKJVayAiLX5nQEojZotEDo89Q7lVZAC7wI72Kgy+sQBkJwBXJ2qV2JqO
 MWg6M0lQ9K6fcjrKQRfTYicVWGT8i+3zLEFtl4FdgsrHzyZMAGCvnm5vAX0CtDCpiIsaYCYmQcL
 3nlEGxndj31JQAUMvDw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX6N+z+uFTbE1z
 ADTXfbzwSqxdk+rtfRBtX4HdSj44+W51Zo+lPwXIPlv5XM0kDyij1UmBbqVddZU69ITtKLZSuZW
 eKmvA7Qgy2AV9bQcbGij74Tl3OChS5M=
X-Proofpoint-ORIG-GUID: NjGHWs7HPMXsheYxoAOK5eaLnU5c-8e4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190085
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

For now, this function strictly returns false. We'll turn it to true
once heterogeneous emulation in supported. Meanwhile, we can use this to
add various checks and asserts over the codebase as reminders about what
we'll need to modify.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info.h | 8 ++++++++
 target-info.c              | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 862097c6c63..923c00c917c 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -42,6 +42,14 @@ const char *target_cpu_type(void);
  */
 bool target_big_endian(void);
 
+/**
+ * target_heterogeneous:
+ *
+ * Returns true if current binary has support for running several target
+ * architectures at once (heterogeneous emulation).
+ */
+bool target_heterogeneous(void);
+
 /**
  * target_base_arm:
  *
diff --git a/target-info.c b/target-info.c
index 254530d8ea5..b8a4a7ebf7a 100644
--- a/target-info.c
+++ b/target-info.c
@@ -42,6 +42,12 @@ bool target_big_endian(void)
     return target_endian_mode() == ENDIAN_MODE_BIG;
 }
 
+bool target_heterogeneous(void)
+{
+    /* For now, we only run a single target at a time */
+    return false;
+}
+
 bool target_base_arm(void)
 {
     switch (target_arch()) {
-- 
2.43.0


