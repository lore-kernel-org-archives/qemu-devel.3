Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFDBCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYkq-0004t3-VU; Tue, 16 Jun 2026 14:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYka-0004Tp-0X
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkX-0000Qq-3A
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:02 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOTLl302756
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HCX5iS0Xm4+
 VK93HqvHW5FUPkEz1caZHsDfOzT2+22o=; b=OwTIcezqt/VXZ+wEdKncFYwxwgl
 d0Vn0eyGPpt6bDZ9cbQVJqPODHoQoBG3B0X4Za0MYB7EDcZ3lqDR+utaUQeoP91l
 MskU5p1Gt1MZRtR5Xx/wLaEzlGD/kwkEzQYkH0gOqGzOpGSlSoZNgHoJGfJxd6me
 bCxBdEKqHj6cqvY2Y4zvxebrP0+vI9XSbP/BAL5YVuwpjFUQMlW5fFdOF5ZwP3Gq
 pot+69C+jIJI/ImEGD8loaGFKpfkUAT1C5Of7dgB3XVjv3L5ejXWzlSRm6lnknS4
 ZhkoTRdQ+jE/XWhslEnW9GuS7YKOY+4QCskiTpo1MD3QlcmwWuG/4KlTTYQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu1epb7d1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:50 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8423efdbe6fso3144543b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781635369; x=1782240169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HCX5iS0Xm4+VK93HqvHW5FUPkEz1caZHsDfOzT2+22o=;
 b=g8GFtJMmkvEKsTeQcfvFx2+lhLYM1jumKPK8cCWviYa+T55csbeZGSubKbmYrEn+n/
 RJ3n9jLgs97W9Wf7mcKx3Dm/P4QI1HTaqWh2RbNEoomtCV92Kznz82LBa7x3titZ4fXG
 vBz0NYPO8mhSv4upQyNDZOdyx0OrqLtQlBb8YVI+aVC17tFcFIBICOEaNHVAGJhVAIes
 Te24xoZcs7XtpaimPgLPHYgU3lG3bhFgY+E0FYFW//zOy1LQLp3FUN80VKrsqRoI/zrp
 T6GtFZWJxOPUUG/f6BA0JcsQsZLF3RgXfFm8B6KHMhBxN58hoHfRu6F3KfsHxNRh9y53
 ew6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635369; x=1782240169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HCX5iS0Xm4+VK93HqvHW5FUPkEz1caZHsDfOzT2+22o=;
 b=SAmL52O2mnmF43Xd2zumROjMWX0gFky0cXcNpe77Gg+WcpOaDI04M0ZGcl0tzTFIZT
 FScW2iefKFoWsLiGodVFC58auuI3F+dn+bnHkehO1KfXdKaR0jWP8GOCKY+OzidSAS9+
 GElm0Q2KNIm4ctvleO1pdZXbLm8VgTvqGoV+PCeTNS9Cf+45R997PPKMPnUltmAYYLgA
 KCrWp5VcVTuk8ptS4NCTRVLzZAcyh6Z4snTDeAJQEUmhgFm8/LQ/Pg1yoeOVymYHEj4l
 AWO0a4+z9oStpXcYNnxImVdqyU8oUbOI+V+bkI7wIAPJIgw3BD4+GE1T1F7duNbn5ace
 pxaQ==
X-Gm-Message-State: AOJu0YwdPZ9LPmcYLJnDPZuyiPTpiwUQEVVoDdus3WzRNT2OPEqXERCH
 JxX2tBRi1uT3yNDOk9sAK/b+rjnYeyBz2Xu3O6feRU3A4TG9FJN0loFst2V1kuZ9NifPBhcMcFe
 /cuMfDn6hs6QUw4jR4lbO85aPeGyECPjMShFIVsSp8eoYNVfGTkgbJHYRhZAWnvPj6a7d
X-Gm-Gg: Acq92OHcUL58sYZ4TqTHwDWKdqWX6ah4C+wcbm0TpEAEf/dVpkLFsEY6nC/sS+FMygl
 Q0qYfUSOlIgJe8h6mO3KHHziRPbjjVx7lhNdSNCE0uTtkvZKwOyom7YmD7y1E+L+jGV5kFbA/qK
 Ziglx3hL8LEhlcZrPbupYlCdzMEG01cbEVsn0ozrj7lOkZkkBqHT8T1Fck4E5nQSpFNfSQMZp18
 MLQoa/ZYj6s4y6VZMz23srBJ+ivU0ELvHVVFopCUp+wtwFfxhUVmn0OA1OYOtQ6iAp3/TJzGlLN
 6I7Wndjmf85lSv3TD9V9jsuAuW1ZaZCMqmB7qLEK7zCb9RQ/7uXInx2ZeZHN+gD4tXNa2asTRsU
 uWj7QKVu6/CIqKz8Sm3UwARzwpzPa+j+mlqejO9WDdp3wrCqAnraM/M26E96t8/PTwS1+bUUkCH
 EVmUw2xKU=
X-Received: by 2002:a05:6a00:288a:b0:83a:4846:90b0 with SMTP id
 d2e1a72fcca58-845247bd9dcmr352330b3a.46.1781635369018; 
 Tue, 16 Jun 2026 11:42:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:288a:b0:83a:4846:90b0 with SMTP id
 d2e1a72fcca58-845247bd9dcmr352297b3a.46.1781635368614; 
 Tue, 16 Jun 2026 11:42:48 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm14602946b3a.54.2026.06.16.11.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:42:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 12/26] plugins: remove type qemu_plugin_vcpu_simple_cb_t
Date: Tue, 16 Jun 2026 11:42:16 -0700
Message-ID: <20260616184230.303038-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I/ZVgtgg c=1 sm=1 tr=0 ts=6a31992a cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=O-HLJylWCwHPwwrsMNEA:9
 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX/h7ahW2K/Tii
 UBJ4QMNdnOqHRkcbNT2f9kLbKc6Pv8yHB8qjTFaGsD1oqre/Vi0YHQSbuVfS7677+ZPAAAuLoQF
 woSE2twW5W3a/i9W4hTnSTfh3ginwcY=
X-Proofpoint-ORIG-GUID: 7YdQ0Ax5KJ0VDjJVbLu4uWz8wQFKbEY4
X-Proofpoint-GUID: 7YdQ0Ax5KJ0VDjJVbLu4uWz8wQFKbEY4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX0pCJHGVMKXfN
 KmhRCBVVZUtBK876OGqPx2MPSpt1gaOfgwPJCA4ClMxlEyjJ4DCTnGD885EZ5tYMOL5VO3oiTcg
 OYwvp5PzcXN/CSezPP2egHP94d6vVjgMti7Pnx7+igNTyh3tGrbptThC+C7doyEE18DwyC0nS5z
 k4v8wM45i1g5EBwkKOXZWf+3uGscbPYDa+1tZVwo9TFyGr5qjjMkVJ5ThwHiAYO3uC038FLlSC9
 +8jsWFrn9SvpV0lG/C7tgTsuffZTmAf+aj82B9VjQYzNJnzBwQleVO/fFdafvXAe1TM7nZBBJMW
 +/8H3hU/UyGtlMfG0SMzR2+G11R0AfBzgMK3w56DCuzJZON7uCL5VLmRFNzCHwmcgd0b/bpd8vq
 4ngXVfvqCCapLvasX4YGc5kpjPz4ePTElxOjLDefdGbrBzf68mqQfPw9r2cSt08ZayjtHrtmWPI
 qb4M1/4jH5C7jhsjkoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160190
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260615193526.2883349-13-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/plugins/qemu-plugin.h | 6 ------
 include/qemu/plugin.h         | 1 -
 2 files changed, 7 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 320644a2f0a..cf937c60ee7 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -147,12 +147,6 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
  */
 typedef void (*qemu_plugin_udata_cb_t)(void *userdata);
 
-/**
- * typedef qemu_plugin_vcpu_simple_cb_t - vcpu callback
- * @vcpu_index: the current vcpu context
- */
-typedef void (*qemu_plugin_vcpu_simple_cb_t)(unsigned int vcpu_index);
-
 /**
  * typedef qemu_plugin_vcpu_udata_cb_t - vcpu callback
  * @vcpu_index: the current vcpu context
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index dac08cdc60c..9356ee836ac 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -56,7 +56,6 @@ int qemu_plugin_load_list(QemuPluginList *head, Error **errp);
 
 union qemu_plugin_cb_sig {
     qemu_plugin_udata_cb_t               udata;
-    qemu_plugin_vcpu_simple_cb_t         vcpu_simple;
     qemu_plugin_vcpu_udata_cb_t          vcpu_udata;
     qemu_plugin_vcpu_discon_cb_t         vcpu_discon;
     qemu_plugin_vcpu_tb_trans_cb_t       vcpu_tb_trans;
-- 
2.47.3


