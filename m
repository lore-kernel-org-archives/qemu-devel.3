Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E46CD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 17:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNDqz-0002Ad-VR; Wed, 13 May 2026 13:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNDqg-00029N-IU
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:58:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNDqe-0005mU-O9
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:58:22 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DH0JY32321422
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 17:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Gmd3ks28Kc1K/HUHGMouZ9on0Yx4q64iReESMw0fXXs=; b=gGxZJkUOTyETIAUU
 Jmu8FV2fBB34t6SwMhEP2qTg8hATRepO+7MNbf3yqSBzBOS2wAoHH8ANX5EUK6HA
 XSHKmbujVUndxJ+u8OupURghdnR9ezI6+kwxZvSyl4I/tnbA5yEAE8VTZ8UoVECm
 luYUhJmszgghkUwV5EszFDYE3qzE4E4hp4xj/6/OO0I3jQN93bTML8pHnU/WaWSw
 1Hau393ckXsgoQnfI6wVg72+F4ngRKQNmwETtHJqbdNVupz3fL2BN0knb9Nf5C1v
 qBdaZfVGVJGtHpa6NclEUPlcwQRDtuoT+6bWFDxT7eGpNpTsU9d9EgPIGld4xqaQ
 CdUQTg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4hgub9j3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 17:58:18 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30230e64087so521811eec.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 10:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778695098; x=1779299898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gmd3ks28Kc1K/HUHGMouZ9on0Yx4q64iReESMw0fXXs=;
 b=GjCsy6PQnUW6bq6dXNq5rTNz8MAHFOONbGvmZMvBY9nf6E6yDwHEd+ul3F+IP0I6Vm
 CR2J8ehGHA8a2Vv7tq8J2VmjZGLcW684YXOdTYXNSRDgRfLfRFlGdhh/HObfQn2aTF0T
 Mo6VacX/Me67H2IVel9TSNGRzE+PlP07qX9O2q06OUgDLOloqSJ56yeMfV5A9lwPvMcX
 JrEkZ/XhSZWbnsEUaHVeK8g9c9x5qkVxIJtWAZUXfjA1ekVu6vMmxNFPCSRP8DDDKyLj
 4OQEWK051BAtVsNhlPvksoauge1pnH+xLrCGfBeScjKJmmYhiN/XNaShl3li3itfMfvn
 v5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778695098; x=1779299898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gmd3ks28Kc1K/HUHGMouZ9on0Yx4q64iReESMw0fXXs=;
 b=QDsEyX9I80fGZX2Dl09DfgL2dfVRw/VV5GEJBBrnPfJ78f3ecOgK4DQG69cE+urON9
 d4kOlaKY+KkcUqN0hkkfphmeG/Dk3HBebw4MlP2dilt8sQQ0X4qnlR9xFmf5muZfWV/I
 76XAUtcxS2yRyNu9x7Wbdf1fsGAtSikX/7sJjOvPw7zPKLxcLIdSY8Mj0xPEdMlM22GX
 rYg7eEB8NdOy659CU4o6EdduiAlqZFxtMDUP2QJ7Uk2pDd/lj1wcr9iTfFolN6SQAOMd
 oOPgxqqAQcU7eA1ijJYHmR7bgx5dDtmCLlqDIdzphvfEnwIpXDLYicjAD1NaM0Wor9yn
 mwAg==
X-Gm-Message-State: AOJu0Ywwi5PksHGryXO4r8VMLWc4FVY9m3N5SUEmgyvbxJud0phZ0i7H
 dfWu9p+Qg5UfXU9UYHiko/pmVe5orj/oqj4eauvhVFasLioI/GU7C+6aoLqg9t9wm86XxXuoOfY
 SOeNGZwXu2latSBspUGywsu2zDlqQXqLGKVfMgaImQLc6520Qr5h+HewcSOEpp2Myq9Vv
X-Gm-Gg: Acq92OE3Dyz1onW2uBXjEt5509DrAVRLed+O8f0CBKRDhulxcYqVjScpPL6wvZFM+7+
 LM8qQgdSn5HeShMwmUDMCKzkVNdhbeFyxlW7RiLBDIJaLrloCfoCrLlpTku2c1AOqoZPXgjBeKQ
 qmwZBxIVH/wmX1uef331MNSOoRR+OROpr1xj1QgUDMAb5mssjhCPeKT3uZZlPCc9UaQCPyFl3AL
 CHZgJNlSesz8pwxBITo0VyVXLFHtXBcaGcJReAwMtkN0zYL4hxYmQ6pYXK3jgaP5SHmaEDlzNZ8
 UwLIUu+Waao6vBR5/5bedjjTBPGf7GEGUiWu/uymVi1hEm9cjQn/7tmAkiP6Im7JGzeQAyM/BdK
 E0KZicEA9HMEA+r+l6h/8/FkFtQ74V6i2oS76qvQCphPscnw6Vql8hM+B4cuD/+yunVZo9qDruf
 YVWQQ4MeYXORxzSn1q
X-Received: by 2002:a05:7022:907:b0:122:3a5:fc42 with SMTP id
 a92af1059eb24-1349ab4d166mr2397960c88.20.1778695098084; 
 Wed, 13 May 2026 10:58:18 -0700 (PDT)
X-Received: by 2002:a05:7022:907:b0:122:3a5:fc42 with SMTP id
 a92af1059eb24-1349ab4d166mr2397934c88.20.1778695097531; 
 Wed, 13 May 2026 10:58:17 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbcb9ed3sm236569c88.1.2026.05.13.10.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 10:58:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/1] docs/devel: Fix formatting of `Error **`
Date: Wed, 13 May 2026 10:58:07 -0700
Message-ID: <20260513175807.3557565-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513175807.3557565-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260513175807.3557565-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=X4di7mTe c=1 sm=1 tr=0 ts=6a04bbba cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=PzGKxP3WAAAA:8 a=EUspDBNiAAAA:8 a=hI-P9OcAu-zlwX61ZcgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=zCCnohV0i-_k6euCn0hJ:22
X-Proofpoint-GUID: VHLzcdeLm9i0a-2938osVNaONN8g3e-p
X-Proofpoint-ORIG-GUID: VHLzcdeLm9i0a-2938osVNaONN8g3e-p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3OSBTYWx0ZWRfX/xTif4YN9JV2
 KVvfZJ+IRrsQE7E+KZvBkM5kXYXCJiTwt6gil9U38fGP6wzlm5v9TnbiMNgxA+aiIj/mcm38JHL
 MYykR5JlWyvrROeo4A2jTToacMWktDBM8PEO/DrRHSm7N3YVXgOtHRI/ZEHU+pXDGXY5rx67WtA
 AAUxyAcLERj0VHzXDUsXGn3sTtY+DrzH5dLegqXeMr4mkd76vAAXzUVXagLzwpMI2WNkVIOraG7
 kWW6N6qiCZZD6ad/p7Gd5YiZQKwa69xagCF/RNyTyMhxP4efKFQYfJeearfCZrXywmt2aLinJjT
 GlctPU2zRe8fB89W6v8UDBvyIJ19hqmgZzKFElb7RKgL/K/NhMG1vU1OIrvWf3cwb5uSpV5+3x/
 ZkijHLI7nNA5gXPwbnapecAYR+JZaIyCLo63u6IdAwP/rgKE+agukxPzL9kEBOrxH26dEz5saNE
 +OyDi7JMQvwWcPC1CxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130179
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

From: J. Neuschäfer <j.neuschaefer@9elements.com>

Since the ReST conversion, Error ** is expressed as Error ``*````*``, which is
rendered in HTML as Error *````*. Fix it so the HTML output resembles the
intended C syntax.

Fixes: 336a7451e8 ("docs: convert README, CODING_STYLE and HACKING to RST syntax")
Signed-off-by: J. Neuschäfer <j.neuschaefer@9elements.com>
Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260513-error-v1-1-49fa04bc5c22@9elements.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 docs/devel/style.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/style.rst b/docs/devel/style.rst
index 12e509d10de..b8edcf9316f 100644
--- a/docs/devel/style.rst
+++ b/docs/devel/style.rst
@@ -784,10 +784,10 @@ error, non-negative / -errno, non-null / null, or Error objects.
 Example: when a function returns a non-null pointer on success, and it
 can fail only in one way (as far as the caller is concerned), returning
 null on failure is just fine, and certainly simpler and a lot easier on
-the eyes than propagating an Error object through an Error ``*````*`` parameter.
+the eyes than propagating an Error object through an ``Error **`` parameter.
 
 Example: when a function's callers need to report details on failure
-only the function really knows, use Error ``*````*``, and set suitable errors.
+only the function really knows, use ``Error **``, and set suitable errors.
 
 Do not report an error to the user when you're also returning an error
 for somebody else to handle.  Leave the reporting to the place that
-- 
2.43.0


