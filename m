Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C997FCD98E4
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZD68-0002RG-UN; Mon, 15 Jun 2026 15:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD60-0002NH-H4
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD5w-00018j-IG
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:42 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FIx6OD3578149
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Ejk2F2ptZ5c
 GsQkciGpQQLG73upgLrn32qRb1yp676c=; b=iEGz0OqUjLVdTseLe4cYxyfEUoB
 yiHTUbrpCZ1gkTgXTUunKK2aE7ExwOjNaafA7Z+VwhTrzbDjRDFpS1GYlcUwkAOI
 GjMd/bkBJQdPMvUF9AAd8XkqzNvDAJDPbuTR4kqKJrcvDOVj4hC2EAbWUdbminCS
 1yzBxl4URPYtwDdG6yVbndv+y1qJEhcrIz8wl6wUQ3cyk6JMAQeA0I2rSz/Jb4rK
 JeN+erlCKZbVyMH/sArdQhO1Prt0B8DkUfgEDYgJ9kryK2Jzg2S3dCibuFxf0zqI
 4Ov/tX3VLP+vSKn0C8qy6eee8TPMTgz0C/FJgs2JPqzxFgul+uHl4378TbQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ete982s5g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:35 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1382674ba2eso3368918c88.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552134; x=1782156934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ejk2F2ptZ5cGsQkciGpQQLG73upgLrn32qRb1yp676c=;
 b=dxpQpFbZfxKpyjzSUkLmtytf4Y76tg7ncFf2TnX08LLUzZwfqQ4yq/98M3XTPUTf3Z
 dTIpkwL693VZOWlVXeBs8lG2DU2MeEwF7QUZ8ppzzUCYylVTwrgy3ov0HtjefxH3DFAU
 iXdddbytEB2sCypjexh+Rn/0LxO/v2vT093lCDL3D/H8YFtjdcvLUYgw6obO6nnunyUa
 fcM1MLnEGaGrtIZqSfTkvRyoAoUwREqIGz+xT/Y5B0QHW75MkPahuDjm3WJ8Igs4Ktx3
 me5wiGaUBqZE8ZdnMn7QL6EtmmyqqhF6LA+NaAC9G2h8nlC7fVFpwY99cx7+lslCrTb+
 v8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552134; x=1782156934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ejk2F2ptZ5cGsQkciGpQQLG73upgLrn32qRb1yp676c=;
 b=oCIzLuVunb/hRFVQn5PsPy0jSEsTcO7pYyxohTQROZ63zY20ETNnjHa6y7u9My4XaQ
 B28iv5TFQw7nqZLZd0TSSUFWB1MN6vT2l9DJRq+tnYQNTWvAXB9QSiMB8q4hNRALunS4
 Gh7Ay90K8uh8P8bZxreHfm4uKosy3OmovmbrGH8VZm+Um6wF9dMpaw6+F7gOcOSMR9Gw
 2W1yLp1ouC2P664dH0v3682cb+WzxVDibKBkaeCE3lE6rLByKKltElJKFThQuqn8yFoD
 fgDSbW0MkbBP8EZesH048rjxhU+e4tkTXpTHuHD9aeiPNUYUz7sVovmeQEcHcnDmUY6S
 giZQ==
X-Gm-Message-State: AOJu0YxFldUQUkSr4HhAJpOokzwHflQesV4k68kChCs9apoIHuNp1CF8
 TOlkpyhz9DZo/7HQBsmg+wCcifmCOXHzAP9OF7K7h2I/+M77qo7iO/39PQWeYKqDSfdvodkDfkq
 g9fPcFyHDNClkSaNlUtIYxRAdIEmq4QaNOEHZ/Yu+qgMxcCYU930zMPl0BXDBFKg/sikK
X-Gm-Gg: Acq92OFFNQ1u3SqP/nESxYYdPmOTzdILZV3/hL8wt2zGYA3xOcbIhN0ldKSGQl7HLNa
 VoAHlGbeA7BE1DEtPi4R9FK64ANfZOxYXmL1ljMk8ggs36q7LupMgJjJ5XhBQA+0oPXt0Nf0S2j
 RQzsUUl+M/A0tveC8axgGkdHrj8ypcRMuQbiMMnE81dGcHMCEeQZ3hmG5hXXUD8qyQxY4bGGN+w
 VIEJDpIScPK/Z/zAVWWmNi93RGXU6qiLwgnvjh9Ft7wplCrWzEGfddNjeCVrIJ+44cSqZpU0bCO
 1OBXuujRnPCy0jKOK2sOwyTvR4WFUEQ/6ozUPW9Ru6acfYS8rkRYMSEmUUn7z8avh2LMkrdMllD
 SZL5ghTuCRkfKI7/ori8wSkpGxHOCgGoGFHPAuqJ9E4YQc8n9ZEGPlNFFBP9zaioQbFsw6lmIMD
 a6M+U5Yw==
X-Received: by 2002:a05:7022:607:b0:132:5d42:55ba with SMTP id
 a92af1059eb24-1384bb00787mr6198157c88.16.1781552134444; 
 Mon, 15 Jun 2026 12:35:34 -0700 (PDT)
X-Received: by 2002:a05:7022:607:b0:132:5d42:55ba with SMTP id
 a92af1059eb24-1384bb00787mr6198146c88.16.1781552133937; 
 Mon, 15 Jun 2026 12:35:33 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97bf09sm11498007c88.14.2026.06.15.12.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:35:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 04/26] plugins: remove type qemu_plugin_simple_cb_t
Date: Mon, 15 Jun 2026 12:35:03 -0700
Message-ID: <20260615193526.2883349-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V5tNF+ni c=1 sm=1 tr=0 ts=6a305407 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=v0NQEDj6idUmN-g72lQA:9 a=vBUdepa8ALXHeOFLBtFW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: eFF6bdbRy7svL4ZVIDJpOJiWEP3Pa838
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX0DjB9NTvG71F
 VdpQuk9Misvd/76n3OC/aJqj29C/cXXwIjOWwArYIlJDRI0QU+TAf+IGVj188Tyb1kl9IwJ2xXi
 8jdkUOrfXKs7PT2/2+kXmB6KlnB6xRY=
X-Proofpoint-ORIG-GUID: eFF6bdbRy7svL4ZVIDJpOJiWEP3Pa838
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX1gRpsh4he0fy
 1GvQAct9hp/K+8Ef2q8btZrFm2S6Y/xZVcWvRr5iD2UsvmClGWXYzfjNWuOHtSsjZn/Q2lhbyg0
 gDJBs0hqDUkWcT9b+zIg3xtkS+HLmJzOTkxeNp664GFR/lf3moUeXygH6CsQuoM03hAwCyLg2E1
 oE6nm64+ZWL9aWcFqy60wZsPN4EeKYPJK6MaT5rOg7LEF4sk90iah+7TpWBBZfkrCsD5yQnqzMp
 +7YUCfQ1t8Dgn53TPyPBViJATIyo6gAJR47Z4/Oe3cTqDmdScUBPd+lUpiGvQWYlYySA5HBRxOg
 oTgprM1FKSp2O6WL/orOalzSSLO5/psP3fEkgztrniNCsKgz4ScsSR0TRcPlrqVwu57NNrfWkP+
 0I5mJOfKQo4Z1Ycocpnpx8bwspsvV2r4EMvzNK0kj278Rx98HwGmlOr4tnaNR++BjX7hxpJlKwg
 +MnG/Kcx9thNiccybGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150207
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

We removed all usage of this type, it can now be removed.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/plugins/qemu-plugin.h | 8 --------
 include/qemu/plugin.h         | 1 -
 2 files changed, 9 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 499441bde23..3c6f32bacfe 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -140,14 +140,6 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info,
                                            int argc, char **argv);
 
-/**
- * typedef qemu_plugin_simple_cb_t - simple callback
- * @id: the unique qemu_plugin_id_t
- *
- * This callback passes no information aside from the unique @id.
- */
-typedef void (*qemu_plugin_simple_cb_t)(qemu_plugin_id_t id);
-
 /**
  * typedef qemu_plugin_udata_cb_t - callback with user data
  * @id: the unique qemu_plugin_id_t
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index ddd77bd82c9..dac08cdc60c 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -55,7 +55,6 @@ void qemu_plugin_opt_parse(const char *optstr, QemuPluginList *head);
 int qemu_plugin_load_list(QemuPluginList *head, Error **errp);
 
 union qemu_plugin_cb_sig {
-    qemu_plugin_simple_cb_t              simple;
     qemu_plugin_udata_cb_t               udata;
     qemu_plugin_vcpu_simple_cb_t         vcpu_simple;
     qemu_plugin_vcpu_udata_cb_t          vcpu_udata;
-- 
2.43.0


