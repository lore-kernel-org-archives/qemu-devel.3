Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC32606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HO8uWROW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NpS8TLWU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJaup-0004Dg-AU; Wed, 21 Oct 2026 14:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaun-0004DD-DY
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:19:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaul-0000Cw-NI
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:19:53 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LIInsQ1932458
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AQJBQS2tObu
 W/AiSQnR/gEcSndBVE2qxsG5JAzk7Wyo=; b=HO8uWROW+bqZqMSdkFIQakVrynf
 ux5urqzBGeY2wf72FnGiPXi0NWG4iGwzkDuhzF1tl49ZYieSrxQUh9qqY6p8hIqA
 NNGhR2/VitxplalVAbmUyOGDeuS8PGezR61uNmD+/Sbm1O/95vFjMwGdNwxolNwk
 XaC0cWNluQHkn7b249JAHvnejCxPcIgs6vRIduzcCanVbacG+pojgBCgkVzmbKeZ
 eyaPdOOLKgcQLSFMJ2/bj6tpsy3VaeaMdI8ROnnAC2YTGSY8tkUPNxoLUY278AON
 YLJnphz8ExLOMlNumcQgnpWmqygkPkt7f/PBxv6K1bme8zesyG4cMC6N83g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0v88fwx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:19:50 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3a4a0017549so2717188a91.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792606790; x=1793211590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AQJBQS2tObuW/AiSQnR/gEcSndBVE2qxsG5JAzk7Wyo=;
 b=NpS8TLWUxk2CXJyvI8NYAzyOw6psl8gQLkeIoe98V97+WmLYcN7u67p0oCD+Wk1kes
 4MQ0eXLZEhKGgUxZQLh/rJYc/+b9pYh9nivSTkNv6BLpdl5sZzgZgR2ZMam2geAdD3GA
 D28qR0XNMvuqaAhb1y66MEW37qL+TJk1jHOycYpnm8gzpvfWzZOWTlOekGKs+8I0jvZD
 NrWmpW6JtGf6Tayc0D5GJa76CqaaSGDL5NF4EE9rl746af0NdhX36eQcHKL+lg9eWbZ9
 fUGQvi3RWXqkT6J13cRpoTo7XKudx9bFfdAhwSOnHEyTCccZv8xdkxtMuj8yXwlEEvPB
 KmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606790; x=1793211590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AQJBQS2tObuW/AiSQnR/gEcSndBVE2qxsG5JAzk7Wyo=;
 b=g9PPlcCbhvWBb5Tu5zCZvBRD1dpiKNUANAWU7DXu2xsyj0O6QobrMvH+qfzfDpHJQ9
 We49aJfhSmaEPy4T5OiXn1DEKHmfYtEPz9L9+t8NQH9ES3vxUK2xqSRRi/SB1113gKzA
 +W99HpH0uoDCQPvZdEhDBbQglJWWLQBHVZuElhf6hT8JyMfqE57AwLw4/nnC+V90rAKZ
 R0G1EIDJ3295F4uS9ip8OLhmV9z00Twi6wyE/0DdSz/LmnqwFkn0i8xMJEl/NgRYbryY
 U5tAF+Xi46txGOmHru+WyAfU7xm1P4f+pswFJV9LB7eiajwDxJLIkp6rRnhOAc/IklL6
 1OHA==
X-Gm-Message-State: AFq9FYK5LlcJo0qQcOskf83iBtXXCw1+jqH46VWKEsicH5jxVXFH6ydu
 /fyjjD35E2aEmxpxnRrpmGGZtKY7J9ZWwUQ4guS8sT4qpK6NgX8ACrPO3IogZ4lL3RWVL0Ofe7I
 JMXJm8HvmD2d3qXpnQQHTxdCaUDe6OJCYOLE2Pco6G9ajTBQ2emvE97rcV/QlMT2LYw==
X-Gm-Gg: AYBFou0jrZSWwDGf9q01EV7gnbLWNRLqrD01jGgOZiBseWJkdHzNasRcRTHDyDrU2N3
 MBQ7c7pZ02l+K2ZVi4MHllCdws3DRDewHmosCdJ2hwanrVI++btvHHNTtVmsP1o/GNUgRoQ0a8l
 B7ZMDkFn3/xhKb/kBnxtoik9YUpoALEX+/8f76L55cfBEcOuCrS4or6DwixF36rLdcdy/Wt+eMD
 Ka49CX1sfTBe++kfZE/X7ASiJhp7OBslg1HvB1jrTSR+n7uQKgjdNu8oIiZLxKLJPguyDKY0Fpg
 GD7qfUuEQbKHBFg6fV/rQ0Hu/xfdxkBWSnX1XuxnB40qqWJtV8iJW4Mk+LzV44Xl+f/3pgWfM6z
 3MkQCJC7Po9nNYD2Azgu4copJPzEtP0MXUbMst4p5XzjF5hSxbLaorAyebwm7yJo=
X-Received: by 2002:a17:90a:d443:b0:3ac:af8b:6f4 with SMTP id
 98e67ed59e1d1-3ad86f2965emr2004758a91.37.1792606789648; 
 Wed, 21 Oct 2026 11:19:49 -0700 (PDT)
X-Received: by 2002:a17:90a:d443:b0:3ac:af8b:6f4 with SMTP id
 98e67ed59e1d1-3ad86f2965emr2004738a91.37.1792606789184; 
 Wed, 21 Oct 2026 11:19:49 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48bcf45sm521701a91.15.2026.10.21.11.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:19:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/1] ci: add automatic retry
Date: Wed, 21 Oct 2026 18:19:32 +0000
Message-ID: <20261021181932.9555-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021181932.9555-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261021181932.9555-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=C9Z8WgP+ c=1 sm=1 tr=0 ts=6ad90246 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=tvjTBfmJX5djJxn3ErEA:9
 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX6j/6Z4FpAYcH
 X0Sc+Ip3QvBiGAFexrruwQgnVxACdQ0FJFW4JAWETU70Qm3kKb8PSJXQ1IVc2UHP6OLzY3x6CWc
 9/Tc1fluwh9cb6dH0r1PBjeLwvOBIHM=
X-Proofpoint-GUID: OihhjQ-er5EwGh126ZTdTa5pOJjHIFkd
X-Proofpoint-ORIG-GUID: OihhjQ-er5EwGh126ZTdTa5pOJjHIFkd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX926gsJTypv/C
 rjxoVvaYO+dZM6sTpytmCfDQWykzeK7o3vT//mQJLQn7EBvbFjb34oxKy29e7Wvfuc7nFYwyZ30
 Q9ldB/gN0npYzDasWMSo0cp/WIHyEBLg0Qpbd6qdUFd6Q2Pnwtl0FR3YiAu4uVwrJQice7Fxf/i
 MZL8lxj5UAzN40xUQGupirPQXy89RyM4oGg9dQv9DU61Of3nW9eVKuLtDAsa747n5v1nWOTZMCC
 QcCwti2gvBqboeJS2bS3lG5R0z3jWwGDLwcK3zPdYF9zOG+a5Vc4IGpscedle2ssKfj6RRvdzM7
 9pnpsLOAH33AEYcn0BAYWJENuSBSln2G3xTZ+vCNxumE09EowRtax9oCRgdHMiTcs57B6socwVS
 rRKuBVI/Zv6n/seaOVQbu0cdpEnOInUuMD3H4Ztz+u07l21qv0TwxYPU70986S7N/R74cVqo5e3
 iyPqN8Wk6ba/LD7P5ug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210072
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

When merging PR on the project, it's possible to observe failures on CI
that can be related to sporadic test failures or infrastructure issues
(pod eviction with Kubernetes). As a result, it adds latency on the
process and workload for our top maintainers.

This patch sets an automatic retry (supported by gitlab out of the box),
so failing jobs are automatically retriggered.

It's important to note that in case there is a real test or build
failure, concerned jobs will run a second time, and fail again. That
said, it happens seldomly since sub maintainers are supposed to test for
this before sending it. Also, the retry is limited to the job that
failed, so it should be cheap in terms of CI minutes.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20261020231602.24344-1-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 .gitlab-ci.d/base.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index 8fe00809357..63ba82e3632 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -31,8 +31,9 @@ variables:
     # Ensure docker.py / tests/docker/Makefile.include always displays stdout
     # from any docker commands to aid debugging of failures
     DOCKER_V: 1
-
   interruptible: true
+  # automatic retry on failure (sporadic test failures or infra issues)
+  retry: 2
 
   rules:
     #############################################################
-- 
2.53.0


