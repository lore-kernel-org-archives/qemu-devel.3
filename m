Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24260C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAjN9-0007Ha-GB; Sun, 27 Sep 2026 03:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAjMf-0006wF-Vr
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:32:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAjMd-0006Pt-RF
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:32:01 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QNvhVv658307
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6SQdNVBNKfGtXfDP/qEYk1lZmc2wZEFE3xcklehMAxY=; b=dJYykUY4DwJ+Av5N
 jH616BM2dtLP+THlqQsJdW671HowzNMBHz6cTGSOekBcdduJfnZxGMrENcmnquGk
 MP1KU6/5OAHT2h17q2F/XW6JhjjnE1BynGhM34fLcdRYZwuqR0wrrGIPY6oh3Ozv
 vqQf3o9+6KDXaf8pJpO5/VIPrJMQSK8WhHgAoem1gZV6yv2CpOfHTLFCrSPG4c4d
 Vj+uX5H2MpiN1uupOJSZnI5CeQCMCAdnFIMzYWhPYqiz/JYDMt20/Uy7cz+7eyrr
 GqLAc9eYF1dmNWVCHMyjRewCrHW3vf9xBI2f3BcZklgZJrtNkQ3GeBWQkeCNHz/M
 nn3yzw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx6tejdrw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:31:58 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93bf4c0af4eso575474485a.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 00:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790494317; x=1791099117; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6SQdNVBNKfGtXfDP/qEYk1lZmc2wZEFE3xcklehMAxY=;
 b=j97IzFzZX9e3wyrWN9X3mV2u7cseFexpRIAvQdh8/2PIUP5kLjfnKys0GJtTz0tggH
 0McgE72vcj5LoTEDsHZM5saOu+QykcrOysE7tPozalqQoYtLfc3K01W6AUjxfDlohoAf
 KL1d8FW5RLQQ88ffRfbZ9AWN8zlUonapSVAXFpIbbKbiMW/HoeOOg3QDb3C8q9WU3anj
 Lem80zvJlKn0p/+GBAWzVNhD05Pg6vzyt2LxmPu7EERwjX0DKAMSTocnWS2yjzYoFjTB
 ISc9yjI3vO71WB7DDlp0IAONCDJyYnSRuPh8kr0Rco1R+ebcvaD1v8dph9Ors7RQ29ES
 PkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790494317; x=1791099117;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6SQdNVBNKfGtXfDP/qEYk1lZmc2wZEFE3xcklehMAxY=;
 b=dXEETOrXMSbk/DE11ARJ4ZMPurZ0tP2Uhvmp8SjA61F+jBLD/bLycVOltHu/z41WeR
 8/kOFaUogOCRllZYwmzn8hkgmL3V+UCSzS/YQ3WGLLtP8YSt5Aosd/BLxaRuvmKIhJ27
 IXPbHhfQIsoXkxShyrePUbtZyZAskjPOopVzZdVs262JMdWBfYQtjYNF3HQbdpGf4WLN
 e3VYJq6+oS3lLWZ6bFS4nff6dT8djzoN6hQDq4kUxf1/ts4KJ259UOJ/LZYQKN3Y5z4C
 tJCCJvvk5xp8nDfjH1+jO9lB2oZqZrZmYMlPYdFXa39XpD8GWgwXNSAJnDvDEI6FLdpe
 2evQ==
X-Gm-Message-State: AFuF++mhFSFqkl6kLJOO1rK24nQcs/X5XVnhOFfRASoKOG0DO5/5a+V5
 u64/SCiaGHp1fho1fxFcBz+q85bLZxx2z/Ekdamy68XjyVltneWS8eHvPJ1lrrTIyAUm7Zdp3EU
 0UIs0XkcpuyPqR7ca8hsnIVSjCFOEgdgBA+KfNqzCXaXKb37t2unW1gKApg8uNrONOg==
X-Gm-Gg: AYBFou2txAqSSC1thso0PUNWU0UzhXejNzjVrog6xwXN38EIhSd7t6yeDKghCELQMPv
 drnmQUVqaFCvHAR1nrWmWAUThxspngx0UbGeilLS34Zm6BHdDEE9n003ZU7j01TzctpTvRmoImf
 wSDMkhPPFanBoTwe32NSPLcin/IJ+D38sXzgv85vjdgSj8eTPmv3AORAYzi7RvbYlqkaD7W+VUK
 XgiE03EqQ/iOFXVdmN0tUKu6i0NNXvlA1ryYydXc9JfdXS+Ue44B6f7K4Yx6hAxWmMr0pawE1CC
 6U29qUVE32iRtx3da5qgKlT4i5maS3Zujizda/CybkbY2tBItOC6IfjrNfH8Vmp8v8Ju55h+a8i
 wPrQUb5RHmxbBYQzIqG90rdddP1Ki9bo/rwZNK/l0
X-Received: by 2002:a05:620a:bd4:b0:939:a9d4:7023 with SMTP id
 af79cd13be357-93c43c2241amr1315481885a.10.1790494317373; 
 Sun, 27 Sep 2026 00:31:57 -0700 (PDT)
X-Received: by 2002:a05:620a:bd4:b0:939:a9d4:7023 with SMTP id
 af79cd13be357-93c43c2241amr1315480085a.10.1790494316819; 
 Sun, 27 Sep 2026 00:31:56 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0018dcf59sm52035275e9.1.2026.09.27.00.31.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 27 Sep 2026 00:31:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/9] hw/qdev: Clarify instantiation and realization
Date: Sun, 27 Sep 2026 09:31:33 +0200
Message-ID: <20260927073140.41422-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927073140.41422-1-philmd@oss.qualcomm.com>
References: <20260927073140.41422-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDAyOSBTYWx0ZWRfX6Um2ZQS96lzE
 riTGAtTUvZsen7pj+/bRF4fpS0iJCmJHwMaPRk3svL29yQRWgZYJ0BZlFppGnN22qY7TWiIJfkR
 h8wyRXQNf/KJJTP+gQt0e0H9inUPlWbgOlEQkhooSvMno+vmWWF8Hw9sOjNjPjEH27FofFKWfnZ
 M4+4QMEF9Uy7sL3uuis5FiAgNJ22Bv5qors0Tz6W/Z+zuHhtHHSGR2PsP0MM8XSQ2NO0MebyMqk
 FjG5uG8Hiz2SN8hD59Klb//uco0navCNy+RWiqR+6kUzltjI3JpONehVpNAXWb0ZLQ96CidChkj
 6qAbG+tTWbjjDm//9c7F05WAxcOLoJnLypf4soiE/4KOVpLJUfZTeK/wuYVuVvLgxNb5II42QRE
 b1Fjni7VFKwxTB9xwBUNLMLQuUnlPj/WrHq2iPpdnZZSzEMWK8ADiZAYTKmedpt6ylVK+dVAcVj
 qhOPkDJgb5W32sqnJeQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDAyOSBTYWx0ZWRfX+if8Uaygo1R5
 QHKOUTG5Q2zLBgZ/6C4PoLaFCnyzpGA9a+H/1Sbj8Jx+htQvuWtXYV0Wu+KAIJXQPp+873+doF8
 Vc0yYQXnJfbjbDd/W7MzTAsA9pDAdNY=
X-Proofpoint-ORIG-GUID: AnZK_yUNYmysa-kqX7GOzVNiloftx69s
X-Authority-Analysis: v=2.4 cv=X9LHu2Te c=1 sm=1 tr=0 ts=6ab8c66e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=ZiMIAIO6AAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=tLtHeN6WSEounkZ1EaUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=KohFQSMcaiS2QNUyYz07:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: AnZK_yUNYmysa-kqX7GOzVNiloftx69s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270029
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

The distinction of instantiation and realization was vague in the old
documentation so this change clarifies it.

The old documentation said:
> The former may not fail (and must not abort or exit, since it is
> called during device introspection already), and the latter may return
> error information to the caller and must be re-entrant.
> Trivial field initializations should go into #TypeInfo.instance_init.
> Operations depending on @props static properties should go into
> @realize.

The first problem with the old documentation is that it is unclear what
"trivial field initializations" means and why triviality makes
initialization appropriate for #TypeInfo.instance_init. Another problem
is that the documentation is not comprehensive enough; for example, it
mentions @props static properties, but it does not say anything about
the other properties.

The keys to distinguish instantiation and realization are instance
property setting and device introspection. The fact that initial
instance property setting happens after #TypeInfo.instance_init and
before realization implies that operations depending on properties
should go into @realize.

The fact that instantiation happens during device introspection but
realization does not implies:
- Instance properties may be added in #TypeInfo.instance_init.
- Instantiation must not have any side effect not contained in the
  instance.
- Any operations without special requirements should go into @realize so
  that they can be skipped during device introspection.
- Instance properties added during realization will not be configurable
  or introspectable before realization.

Note these two facts to guide appropriate instantiation and realization.

We also omit mention of the realized property because it is a QOM
interface detail, not part of the device API.

The statements regarding a future prospect to propagate the realization
state change are removed. Device realization is propagated to child
buses, but not to the devices on those buses. The proposed recursive
propagation to child devices has not been achieved after 13 years, has
been questioned [1], and is not relevant with the current API usage.

[1] https://lore.kernel.org/qemu-devel/878syd84s3.fsf@dusky.pond.sub.org/

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20260914-qdev-v4-1-93f849b4865c@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/qdev.h | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index 1f6bf3fc1ab..8e91e2fcb08 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -23,28 +23,27 @@
  * Realization
  * -----------
  *
- * Devices are constructed in two stages:
+ * Devices are constructed in the following order:
  *
- * 1) object instantiation via object_initialize() and
- * 2) device realization via the #DeviceState.realized property
+ * 1) #TypeInfo.instance_init
+ * 2) pre-realize property value setting
+ * 3) device realization
+ *
+ * #TypeInfo.instance_init may not fail. #DeviceClass.realize can
+ * fail, returning error information to the caller, and must be re-entrant.
+ *
+ * #TypeInfo.instance_init should add instance properties but must not
+ * have any side effect not contained in the instance, since it happens
+ * during device introspection. Any operations without special requirements
+ * should go into @realize so that they can be skipped during device
+ * introspection. It is possible to add properties during realization,
+ * but they will not be introspectable or configurable before realization.
+ *
+ * Child buses are automatically realized. Child devices must be manually
+ * realized (e.g. by calling qdev_realize()).
  *
- * The former may not fail (and must not abort or exit, since it is called
- * during device introspection already), and the latter may return error
- * information to the caller and must be re-entrant.
- * Trivial field initializations should go into #TypeInfo.instance_init.
- * Operations depending on @props static properties should go into @realize.
  * After successful realization, setting static properties will fail.
  *
- * As an interim step, the #DeviceState.realized property can also be
- * set with qdev_realize(). In the future, devices will propagate this
- * state change to their children and along busses they expose. The
- * point in time will be deferred to machine creation, so that values
- * set in @realize will not be introspectable beforehand. Therefore
- * devices must not create children during @realize; they should
- * initialize them via object_initialize() in their own
- * #TypeInfo.instance_init and forward the realization events
- * appropriately.
- *
  * Any type may override the @realize and/or @unrealize callbacks but needs
  * to call the parent type's implementation if keeping their functionality
  * is desired. Refer to QOM documentation for further discussion and examples.
@@ -102,10 +101,8 @@ typedef int (*DeviceSyncConfig)(DeviceState *dev, Error **errp);
 /**
  * struct DeviceClass - The base class for all devices.
  * @props: Properties accessing state fields.
- * @realize: Callback function invoked when the #DeviceState:realized
- * property is changed to %true.
- * @unrealize: Callback function invoked when the #DeviceState:realized
- * property is changed to %false.
+ * @realize: Callback function to realize the device.
+ * @unrealize: Callback function to unrealize the device.
  * @sync_config: Callback function invoked when QMP command device-sync-config
  * is called. Should synchronize device configuration from host to guest part
  * and notify the guest about the change.
-- 
2.53.0


