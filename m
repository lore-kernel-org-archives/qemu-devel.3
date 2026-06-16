Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E295CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYkN-0004O4-NF; Tue, 16 Jun 2026 14:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkG-0004MO-Q4
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:42:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkE-0000Oa-V9
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:42:44 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOT3o330811
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=9KsZuK315wk
 srDsV4TkH3dSP++EyCXGeIlhzGwP0k1M=; b=pOjKCFgqnFFw7hilxpL9nT6JrDb
 b8SzQz6Yfv0+XTgcfbuET7ZBXOwQQLiYrBrqCi6U1lManaQsHxbSDv9Ah7wNWq9h
 cPw5KH8OPh607D0bfc3ONLrICmzDdzF21WTbSfbBDexJKwO7metOK2afddZuMu+q
 nq1QUktkpvxJIwIEblPgYPRIku1sDxZ4wnZ691SSQaGtUHY+nOwsZx1nIbbAIWx6
 q9+d9WrBLqORXiYc97yLW9AFePp85IZhBfr78Zp/oOxoN2xDoXvPFaURxqdbDGXi
 4h3rb4Y3VFuTvtUyLBXGbmJ7nBcKjMAKwXcsk5Ca8n1NcC5FKqrV+wRQ+7A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu09gbkrr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:42:41 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-842b0dd8107so2966692b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781635361; x=1782240161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9KsZuK315wksrDsV4TkH3dSP++EyCXGeIlhzGwP0k1M=;
 b=LgpvApxhAQeVX4o3FWcbOYsTyNnkQSnf8wbVoJluAWMhT6FzY1zfqBQtTkKuxIxcYe
 yt4oJO6mvUS8ly0zEsk3Myb15pcW5KPJq9pFvKQBLTJyNuV+P0pL6af2LHN39LBctDNK
 Fgbvx1gWdGtB7Re/AnD0cE1II8FjPt7yl1q4rqMFP3TDA2RYG+Vv+ZHNWu/d8lAElGCx
 n5WYUJEU/DoOM1EY0vsZJdONnbw7Xo1e/Dwt8GPhO8npczQ9h+94Y2K4biUkizLEJVP3
 E4UPbRebxZuFtyKHbQSG8gBeefiQQNKh5aQvnmri3BeT5YDFCXZbKEaTz+Bm9cFct7cL
 BBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635361; x=1782240161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9KsZuK315wksrDsV4TkH3dSP++EyCXGeIlhzGwP0k1M=;
 b=Ao5SDkr2zcv3CDD0HiOwQ7vcdAqLuRn1pB7oqOTkRG4caNQ4P7O0qqJZSFaz664WfK
 0MahCBrj0m5SXnu3FQf0qwet4Y4anjwhyk/Dvax4W+r/pflDUVkmDJT9SaWKZT89aIlG
 K6lsgLOKcCfnwf1hyQCz87ZfdnTO7YMb5GN164St91ThkcWrWGGm/iJHd+UU6ytnMw/M
 /ip8fbKwqSdGO0aIhH5fMFYklR1m33fq+kfSQmjHm7t4PilKJozrnsLMb7jSrd5yfJSf
 YOHLFlx+UkJgt0XOpl4AuDoW8qA/bCQXI4Jpz7PsfsADlZIneqBQxXbBXgmxFgf/ajxN
 79aw==
X-Gm-Message-State: AOJu0Yz7V+pVhlAEIfaxM2D08cu6h3cCcKTaNd4ikbWnufG1+Mzilwl3
 ToJtRhMepiGdWBqBClmuZuWD7eAmh9JjLXVZ8n9Z1jtfTD9q4T+wCwpzWu4TS/h9LB8CPv3DHBL
 aflRWsMCqq9rHx7O+BYJwN7pBKoCi707+ZL8xJwavCVHOPi0eKEX/ckJoghzFxjRBzWor
X-Gm-Gg: Acq92OH0SVyqtGEK4pC49JQ1gzNLImwygbyYj5FOk2zAi669zmC+u2bEfUc3wuZ1NZb
 YWpFMmeQ18WKmdN6txD6h5Kd2aB94KlJFi3Xs4DYQNi7cGLarhZagbx9Ybm4Ze9QBPIBhJRkH6w
 Xd9TX3eDC21QmbBLxJUv9OMrELV7wWiehhnHXvlIEVE7KmLvXZZb57khH8b+wVZseXa8a3LIUZr
 BbvdjM1EjeGYT/8xx2j7KHKiaD7Pkw9ugBwmNoLBvjSuPLEQ8cV1NYCqeQsSF5bpit3BZMoL4Vg
 hl60R5IEodryrkYFq2IZ8uR/WfvrLHgw3Y8vU5MUB8mYXII87e5fs21+BDXMcl6GOBeRL3zo6Wg
 8b6Jwpe6ZTF2tQ6Q9HZ5Z+J8Hz+4ZlJY6/PdDxUlVrVbyQc80NdFlKhyTgvEL86MB3mjQWAH+yN
 qTdDPtago=
X-Received: by 2002:a05:6a00:99e:b0:837:e9cc:d465 with SMTP id
 d2e1a72fcca58-845244b2f2dmr375993b3a.20.1781635360839; 
 Tue, 16 Jun 2026 11:42:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:99e:b0:837:e9cc:d465 with SMTP id
 d2e1a72fcca58-845244b2f2dmr375969b3a.20.1781635360402; 
 Tue, 16 Jun 2026 11:42:40 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm14602946b3a.54.2026.06.16.11.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:42:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 04/26] plugins: remove type qemu_plugin_simple_cb_t
Date: Tue, 16 Jun 2026 11:42:08 -0700
Message-ID: <20260616184230.303038-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX6cLHx0TbmoX9
 tN4e9VWdzxHAupUYuoWiYSS7FdGFGtWbsEPoL4X2R3A673b0FkZH+4s6vhDcF5jxS27Crg4+pu7
 4/UGh3LzzJXQrHIA1xWf1qajH9YybUAg8Dk5wj9YqllRRalT6onQn6LeX10k8YSS3yYbZXM5nDz
 YCjjg3F5CIsKt8hmxH0CL/JscYomUmZxJYLO14iGp+dxBpsbK640Y+8+iyn2sqty/uEk7PhI1nt
 RYG//aKQdhHk4/ON8+LB72mFHDbUA+gj0V5x1tjjgNM6WvWrvJwdCeClxVxCi14rv9VJWSj7F/O
 Oc3uvft+ZkAdHxW68yRLjfIwdZudndqnD1EU2Heh9G0w6m+PUtkBG2UePSQRoY9ib3C1bupXIES
 OCoZU5zf01Ccpk13uVbRRdFhHIAZDrnbWuWgccnPy3sHcui52q72NYoXXhGO+KZvNe91E321uyN
 SvizrP3uP2p+1VrvGiQ==
X-Proofpoint-ORIG-GUID: sm35z-DAscIU0N44xy-3daxl7AOkJ7k0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MCBTYWx0ZWRfX9LyDhTodWwWr
 fySoR1Eu/LsjxnglX/+8C3sQBdClDmMBWYyny+3DH2pJ++TIQSnstk0fjN0nCnXwXBOgKOEHKWb
 nSAwfu7dvioYCCFuE2Q1fMLDBlOvsLI=
X-Authority-Analysis: v=2.4 cv=DLa/JSNb c=1 sm=1 tr=0 ts=6a319921 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=v0NQEDj6idUmN-g72lQA:9
 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: sm35z-DAscIU0N44xy-3daxl7AOkJ7k0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
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

We removed all usage of this type, it can now be removed.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260615193526.2883349-5-pierrick.bouvier@oss.qualcomm.com
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
2.47.3


