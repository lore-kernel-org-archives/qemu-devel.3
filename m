Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768AECD4F3C
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNZmS-0003dM-PP; Thu, 14 May 2026 13:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNZmJ-0003bH-Ob
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:23:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNZmG-0005iN-Rm
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:23:18 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EBeQJr3951586
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 17:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1dUHUq2pSY7R6GNpMijZrY/mundsQGHsq4YZCZ/UTds=; b=XtaPd/zj8kEWsg7N
 oFwPjk45QoGBwJkACQcJ5g+SZ06cKuBWK0/LKgMytx48wkxSR06CxL9t9Omk6rJV
 TUTJvXpfv6+nDQLPlNXUthtk5sXvSwauLHS1WoZhIPUWpCSEbEqYiM4RQiJBx7G4
 H9lHLLHahaMYjexIPUtE/L/eMtqKevgUd1jPkAXFpsmlyT70e7SBWYM4vLJCo/sN
 01/0a9HRgQ8AwVr/u61s0mejI2j4b3jDzDzVSOIxVWl/DIYUJLtoNFsIe8k30WFq
 CL+nql7wtMlsNzTrYeWHU0hf4yzwxb2ubga4feJrl0m1hhSul/pdXq8g4qWmPIZ5
 FsEMvA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e57kstpdw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 17:23:12 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2bdd327d970so39872eec.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778779392; x=1779384192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1dUHUq2pSY7R6GNpMijZrY/mundsQGHsq4YZCZ/UTds=;
 b=gOru9nGowj5s61jwobySAYkSQgSoq4X+6/BbusslXPtCy04hx9721vjOvL+pr2WvXC
 oB2asSWWlm1R0B6E68iTJm24coPGjvv+E/A3LWcdJOMLBEnDoJ0rYylXoIWPiwek7mx9
 Fq0aKeHMvipLev9ek+urZriOdMVYnffr7mcYILcrtoU4SYbsFGkY1aAE9BfH+5biwoUl
 /IIFulRC9VtdCM/1DeUMPjdws1yKR28MZEgcX7CmRYbOrFmAOU8BVywKe+VS2cutn17T
 /sRo2KLZ8aQo1emNqnV6dpuD5GHl0eghfPr3O0AMhRMgvpxAVLwBB3HiY+xPYZq8awee
 hykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778779392; x=1779384192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1dUHUq2pSY7R6GNpMijZrY/mundsQGHsq4YZCZ/UTds=;
 b=HLQe/GfBehUhxQSXfnPB0EEGSTzX1DYokVeP8QxJf/08Bl5/GvGKK4k1+pCH+HTMbb
 NHrLPzfi9iYH7Gusv+Kh+fBMPcTgNUMPfcS3oDR+9jEl0nuaTEJ4FVy9zFFs8Dc4jlKS
 yozRsxGu9TY1eC1ShE13kmpohGJ1a922+SlLbJoL+O/v/2OXyIoQRTSyoUDW/coApyPC
 iNyAACslX//DjgJmDBi3eBrQiEoHqCIWqv/4aFnOJs0oPnScE2ZClUVNWhJYf7J6EkX+
 UcNBai3yBLG6vQKejI+GMJuYnRa7FHCnzgaxUE1a/3FGWPbsNG7ocGPsH6YECkEsI6+n
 b76g==
X-Gm-Message-State: AOJu0YyRGv2CXoapL1Ah+2BVLNiVJg4TXjIsFDLMGxuyKlh8kI2NWsGk
 q2tbR08gXyMT7ogjRGWD1ulvLF1s2LSrPxGpq9UJ7bmGKTcE0QeVMAQ3ykSd1ou3JYuBRmMB5/j
 YgDLlRgUDNxXvw1p17ZmVhP/4P42qBNaoBHQVk1Q57v13VqFlGhyPa79RSgQJQBEqazYe
X-Gm-Gg: Acq92OFW/jZcx5tjq/rK0BdBGx6l/W+jWE6YIgvx6yU4xdH9DXovC3nvL0Rq/o3NHxX
 /9rWjjyAWNWPQ7azZ3PqCkrYn3kbE5Sy4UdXW/epzrjOXgIM6urLQzzhQwPq/vFvsPCFPmqBdt4
 SnFxVVIpXbDurDZN8S31fZf+vOE1oxuCMqKe3Fbh9iYUsNOqvlgSUO2FMNk85J6uZhqY85ggea5
 /EaRKWwWjpuM7IuCnAcUmAYaGAXq2bsPh6t7/Hx6R/kjK07WusVdRG3H/5Z2mNUZ06R6cOtImFS
 uSBwqgsvHzV7svZECn63a6NtHRnjQSKvBsio7tagt8NxNnJ7XJT29w1dlPUkHJTnKEIlf/Rg5jM
 B9b/WqBuQ6Zeg8GvkIsNKuronDyVWV51gSxuLxFwW/+f12bG0a7kSnbVmDITE0dgvOTowgEEFe1
 Re6z3bIA==
X-Received: by 2002:a05:693c:2c8c:b0:2c0:df3b:ec1e with SMTP id
 5a478bee46e88-3026188af43mr2689685eec.11.1778779391903; 
 Thu, 14 May 2026 10:23:11 -0700 (PDT)
X-Received: by 2002:a05:693c:2c8c:b0:2c0:df3b:ec1e with SMTP id
 5a478bee46e88-3026188af43mr2689657eec.11.1778779391348; 
 Thu, 14 May 2026 10:23:11 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302944ffdf0sm3828677eec.8.2026.05.14.10.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:23:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Anton Johansson <anjo@rev.ng>, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Darren Kenny <darren.kenny@oracle.com>,
 Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v7 1/5] qom/object: register OBJECT and INTERFACE QOM types
 before main
Date: Thu, 14 May 2026 10:22:59 -0700
Message-ID: <20260514172303.1484273-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514172303.1484273-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260514172303.1484273-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VPVEwL1fUO_Q3FnG-AWCh0oZgW9wUiai
X-Authority-Analysis: v=2.4 cv=KZbidwYD c=1 sm=1 tr=0 ts=6a060500 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=W37sF3GUcAVBL6lWIEgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE3NCBTYWx0ZWRfX7BRahggT0RJs
 S/6jiA7ASSbggRIfuLqMTqgerXIaUbB5MIP5KOD3k56H3LOCIIeNvusCk4NVjUrK1lF/p3kiwIz
 1iLqfVQ2vapQaxewLSUD48ZenKCSHuh9u4uND2vFu+4v3qEv10ST3GGqiX6atUw0eBXR9EUFNug
 yZrcuxG09w7VsHf2g4dAv3/5fEnj52abNDdEeq4hw/QbuJnW15Ko/emNSaq3N+61n08CG+jiO7l
 ehgiNLkpZhOfbyHJDS6hjXyY3qvPdYg3Gcp6Cks+3sN5b3t6aCtP2wJerKyu/rYMfrePMpsIOmy
 ZYEgsKJVmmLiwWcO5ucyTj0irrSjjvivDYt/0Dj3vt4kmsYf67ZRMzhGJe4JwirH3k1AZxoj4yh
 pGCzZTKHVyfxsitZa0H/4mQsRFShGF2kgxw9Oz5VNqc9zfZW6hsmUjW+RaYgFU0NnfyGvx3QuIp
 Sprl9JLi4IPpPZ7qYjg==
X-Proofpoint-ORIG-GUID: VPVEwL1fUO_Q3FnG-AWCh0oZgW9wUiai
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140174
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

Those types are special, as they are the base of all other QOM types. In
next commit, we'll introduce an extra step in module initialization for
target-info-* types.

However, those types depend on TYPE_OBJECT, which is only registered
at MODULE_INIT_QOM step.

To avoid having to introduce another step, and modify all code calling
module_call_init(MODULE_INIT_QOM), we simply register those base types
directly in the static constructor, before anything else.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 qom/object.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 59fd79738d2..b82b65a3a18 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2844,7 +2844,7 @@ static void object_class_init(ObjectClass *klass, const void *data)
                                   NULL);
 }
 
-static void register_types(void)
+static void __attribute__((constructor)) register_types(void)
 {
     static const TypeInfo interface_info = {
         .name = TYPE_INTERFACE,
@@ -2862,5 +2862,3 @@ static void register_types(void)
     type_interface = type_register_internal(&interface_info);
     type_register_internal(&object_info);
 }
-
-type_init(register_types)
-- 
2.43.0


