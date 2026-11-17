Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCB3606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PVn0CFzX;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D9Zs95Fb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTNq5-0005BJ-ED; Tue, 17 Nov 2026 13:23:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTNps-00053i-JY
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:23:17 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xTNpr-0003cy-1U
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:23:16 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFQdFE995092
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /k/BQBAsE6gd5yxKGw1Rgb9iKI4w2fsuUhW0envbrk4=; b=PVn0CFzXBfvJFxIZ
 v+ORWMLF7+/T50sOOG1DAMB+JMF711zeaYuEIcI3w286XROkFZg8QTMGu2pZuPDA
 0mD+yTQRJKvn92EMjBFE+VURJstfkhKLp/EQFjXz7G2ugNBwijuTe1vfrxAedFZM
 YuJylE4jBteadTRGPLeBB5rfKsBTJMcPaNkFsSmU+g/gVPjclNStEVH6F94411ye
 YiwIZ5PBjLrxxn9Qiw3km102xBSFSfompClanb4ggPbZgOeQ9TZ+gf4z0+zjE50X
 MJT0c4GrdbfIAsvPgzcANIfUT4svbnrH1dfDu/esXK5P8a+IALD+xKxYGWTtUegd
 Tn3hoQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0hkd30fu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:23:14 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cd5fd34fee0so81798a12.3
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794939793; x=1795544593; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/k/BQBAsE6gd5yxKGw1Rgb9iKI4w2fsuUhW0envbrk4=;
 b=D9Zs95Fbj18VNGqtca3rnsy7F/boKYuw0jxK1iOtKoO2V4humn6Nm8Nb7VBRIFAKAk
 hogqQ37mMtBSWof5Qy+PC6ToukDguGzNyKpRWE3GG7iKrbAIo8udZPZ2Ch/Vp/8GYeBB
 fcZJo0b3+S9ugisrp9pnrgynqqcnJeOa72atU3J8/3LDe4oHafwiUu9uaLpfDCMrgUKc
 th5auFkmV7lu/EBrDk4GsQLFa3jImtNzSARuYSJJyk4FQRYQAO58L4SIdgQaiS4SFC7k
 7+JgzAy767QppB04B5JHXfLDAMj7IWjrrS6YPALSW8dCpN7YF1mcHA0hk1iisqFRINq6
 0bYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794939793; x=1795544593;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/k/BQBAsE6gd5yxKGw1Rgb9iKI4w2fsuUhW0envbrk4=;
 b=z5EpYcQiy3mQllaBPDiV78yFHvpyvlkoFAobcNmzJc4ILreBBJPwAKiS1QSCyPNJ+R
 r4wkNEnpMqnqABk15LncawXQ2T4phqGuXkBeh/gZkfa3Oa4NFbz9v9apIZcoF9LLwb7I
 lDnexbrfmv9TBYM7n7rzz46/3kOlJOZPkL7MkDKzcuGTce1+BkFFhRwbEJPHNAr5k307
 gyionCOwPQDFxHeeg5JFLnLYRGpfMHWtMJ08rOtMKZQm+UB2Ov5YjyPF8fX7ZPgbehhF
 Q5pa7oDyFWzYzk2Iy4VF+eqAKvuj7SVo8T1YXddP/W89rSnfTr9/UVymNcaOWGZEVICE
 MAJQ==
X-Gm-Message-State: APuU4Z8sjVw85PAIkIMBrfJX58jKoM/KDwhEqvjCd8yjowghgEW8gwNP
 V1SKjTXyqxZ4kldetQTttGDQzArxZATtzBxvpVj//R5RW+7EJZofkOWeJLXquVuekmaeL9A3nWG
 /dCyLSqHA6OaHXAiY3lfWtmdZrKCPUX2OH/wM5SgVR8Np0ImEIFhjxv9EhrxJRZ34Pg==
X-Gm-Gg: AZFdTZfx60GZhydyEN2kDr/tFV99sFP6+Y8J6Q4Mt6AseYJnJoeNl67I9tejhxWdgmq
 ErBTo+BnPVjuu0Si9yi+KtiijhEqQDPB9LfGL9jibXzimJLaMRMqvJtYVLoAIz1tsSpkIg7b8mi
 bN6I7UJdaEtmoWzEfmRYLAwA6Tlx2RrwKLdC8FXbl/NI068DGj5xZ02+GYSpS4ONV04x0uGJrXT
 wOogISUSKbSyYdZHkG/c/ELDulzH6fkvDJdjEiOTKZlfBw3yTjBhFPN6oS00xLxV/cgOxAwjMtB
 SG7WDkX7MqZeRmsMmmPmcFXrBglao8qz2JPQ9eSA/HDH6T/RwjIMKgva/z8KfQ4uuu2fhdA3Ato
 vATu9CCzngB7RlNihcDKvpVjopgNTWqJQ7MasQRCeknabCov44RTFAfFli1kuDdVYL0BvxOHWQ2
 UKlpDCsd7jUrvAwPatMsHARxYIb3RpIV1X/SwB
X-Received: by 2002:a17:90b:3c83:b0:3ae:898e:a123 with SMTP id
 98e67ed59e1d1-3b3d074cb2cmr246383a91.14.1794939793078; 
 Tue, 17 Nov 2026 10:23:13 -0800 (PST)
X-Received: by 2002:a17:90b:3c83:b0:3ae:898e:a123 with SMTP id
 98e67ed59e1d1-3b3d074cb2cmr246363a91.14.1794939792464; 
 Tue, 17 Nov 2026 10:23:12 -0800 (PST)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3d19a32ccsm68045a91.0.2026.11.17.10.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 10:23:11 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 3/3] tests/docker/dockerfiles/release: use full registry name
 for image
Date: Tue, 17 Nov 2026 11:23:04 -0700
Message-ID: <20261117182304.3261165-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261117182304.3261165-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261117182304.3261165-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eqFKXYpX c=1 sm=1 tr=0 ts=6afc9b92 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=zTXboHLKykkbUYI2VpAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3MyBTYWx0ZWRfX92VpwT/Tf7HY
 R/0yOEza9HyQKoT0clDtDcWbxdax6uCZJ7PRhCZQxiQQO7LRol5QwrMCWE0XAstfdlyYDz0ZVj8
 UURMZ6l3yjCOxbO69rem6QMrjCiERoE=
X-Proofpoint-GUID: pPN8wfpZBuBl2SHCsqF45nJ221alimFN
X-Proofpoint-ORIG-GUID: pPN8wfpZBuBl2SHCsqF45nJ221alimFN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3MyBTYWx0ZWRfX/WTlojPASBhG
 jbayC69voDzlIeB7Gq+IfcCz8tnxf4t89xGYswi5xEmM3X9OcvnYrs6IdAp+/GVGsm3UgxFo8NZ
 rSbf8TH0Mz5FFsnzW832roqTY23TtDJJhk/I8ToxclbzBKvkcNGTz1kbEq5ICeocxuquAwERQVu
 MzC+my0PTFtF8+GwVMu6/QVNIvx/9r4hC0k6IP3O1YE6mgfuh+ufUWwwhd5el8KlOfGWeAhibcs
 e5SQnM0sa5hYmbZzc/FkIf/fhU4izgJoJOh5eYruJWcR4sVo9a7e5XmOj3srICN/1CWk2IwN9WC
 ENXhC7wLtO7y4nFt6MzylGgRPZKg69nYFWyaaBFU34NuKqYo6Xnmoc1p6H3/4bD162+R4IC3xBM
 Jxf1bo+kc4nIonDcONhOHrtFuQqUmCTGddMRdsuaOwjUxXibKwrN1mr0JYoUn2kyALHOB7phYVh
 OVQjASaH/uB+IoFs2UQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170073
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

By default, podman does not have docker.io preconfigured as default
registry, so building fails.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261117170244.3180399-1-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/dockerfiles/release.docker | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/dockerfiles/release.docker b/tests/docker/dockerfiles/release.docker
index ca6babde01e..23cd64a9829 100644
--- a/tests/docker/dockerfiles/release.docker
+++ b/tests/docker/dockerfiles/release.docker
@@ -1,6 +1,6 @@
 ARG UBUNTU_VERSION="UBUNTU_VERSION_build_arg_must_be_set"
 
-FROM ubuntu:$UBUNTU_VERSION AS build
+FROM docker.io/library/ubuntu:$UBUNTU_VERSION AS build
 
 # add deb-src for apt build-dep
 RUN sed -e 's/Types: deb/Types: deb deb-src/' -i /etc/apt/sources.list.d/* || true
-- 
2.47.3


