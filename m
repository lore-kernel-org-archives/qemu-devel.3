Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06ADFC5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcAl-0004dK-SE; Sun, 16 Aug 2026 10:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc9i-0003o5-N6
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:48:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc9g-0000op-PD
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:48:10 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDl09k3532565
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4urKzUAK7zcqqmt/YphZ0AATkO45ouEjNEl3ivUIsm0=; b=aQ2+0lkhFxQISUk4
 28D1/autiS/GZE1S/AT1eFJhgxYvEIBGJtD1R3pyT1n+cuhk2Tzf4Sd3fKc6Ss+N
 AMNVtkUimbHlvyF1ssdS4Lqm8wn55G4KPDqU7Crfz73LQt3Z1PPTU/+Xv6PqJu6Q
 kcddA/OXxIHqg7UkCOVLB+Y3mrqt0OHIOZTI0frD0Ou+pJJkLqU6LgELQUPQ3lmG
 iIvyuN8t2xeP+C2DzyRGHyIGvdTuVR/e0LonkP9nZSPdtJhWoPH6+Xo1Xl0RSVCx
 cvQCtMrtfng9DN3gU4yvBexjuJZ/IwgKv8eLIsVPUnjRWZCKQiBqY/nWM3Wst8wv
 q9Mu2Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghf3mfq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:48:07 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso23443381cf.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891687; x=1787496487; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4urKzUAK7zcqqmt/YphZ0AATkO45ouEjNEl3ivUIsm0=;
 b=Pm+0+j8m7TTYVPW0VpkphRUk4QAyTTzGfs/BU1K8eTPfctrFVk/xnjF5lTHFm3Dc3s
 YTUCQs9Xht9VhJyRIuvO1CAygiL9loUR21AZEEneKDvphXrfp80Y8n/0H6DMglcHTAgM
 WXPMSGJI2Shin+5yzQznLK5IKKgrrZg2LewPtc8mCXmW/rTCjyYV5AJHE8bQiJSX2PY3
 9/m53v2TGU5C8Uz6Edy66IuyFq2iDFuRqRZc/+B2OqCBi7wcd8sCUYd6e+vObJSCkuht
 8p0DTyvRsDHPtXlzXwkBlDOYi4VgKIjUm3Czej0685v3HW5SJylONDleIHYfZq0tfMm7
 bBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891687; x=1787496487;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4urKzUAK7zcqqmt/YphZ0AATkO45ouEjNEl3ivUIsm0=;
 b=IZkTbWUK8oxrq+qAGrobAgETvepyCNQ5iUZhK9ApP4JmTu+/A2XFP16DHw9Pkz8sVL
 ooL728YUhDKrni55fMACgrga/imdGLOys11nBic7huwJP38K21FeCK3D2ngT+WcXCr82
 6ZS/O0bQEsuUCRAZ8oXMTZKGyqY9Lq3nIvfGEGSeLHi08kz/EfzLlJg6kW7EUKgrVLmP
 UfwFr6Ba+QhQXEq5biIebFZzMBdZQpeEf6EsgjE4a0HeXPyjjDH6sShgZE+xmcdDP6G7
 6rbm80T3ppeZH9X6ZBIKo83rSdTDo8vuMIUlV+uOO8K9bdK78z6+0ynhw0S9t7Am8dpY
 DIQA==
X-Gm-Message-State: AOJu0YxwhXdVHaAVF7n14ctE+vSJIkJsMFkkuo6bDmahe05lTgqvc4+O
 voBSeS2Rl0DwnVf3uPR8Fyt0KNFoEOT2c2FxkPWnlH6WV8oUt0zcKi9t3ECplAbODWzZs09x9+z
 Y3GWXkf+KRLH07GiBHj0nd/sDAh4leTK4Oq6VcVYzLLPwVBgEWobCrQ4s1zimjBqp6g==
X-Gm-Gg: AR+sD12KBhYJ0qsh+vButEOGbJMFZYUUE09ipv04bEr/MugzVOn1CVetVbVWWi+qI6m
 CVb4Cytr+NLLBwoXzKQs32gDl/TAr415oJYVtPkqc05BMdzQH3usaKF+cTHgdJFbFGiMAklNIUR
 6fXhdeE4kYE8WOSwSQa119Qe4gPN2VpbTAmQ3cpV2x549kXFLABmc/IXX6IdircHI1Also+MsRj
 tuFORVK9Psm5KxVm6vWz+NL4BY8UnxKfr3SL7MfGoFPE93Yi2G76N9L8yjWS1SuqhvUQqgqMDpJ
 b11FVXS11uDnLqEoquyQDt+otZr/vhH5rgq7GqQopHmUuYRC0EqlKo0WeaF7U5jGA8b58UgEv3E
 iRq8AZlQUgBxSHJ9eRLvjR65dVFD+QzTVTz8IXlBszQ==
X-Received: by 2002:a05:622a:250a:b0:517:c65c:4987 with SMTP id
 d75a77b69052e-52d74baa1femr319052291cf.22.1786891686869; 
 Sun, 16 Aug 2026 07:48:06 -0700 (PDT)
X-Received: by 2002:a05:622a:250a:b0:517:c65c:4987 with SMTP id
 d75a77b69052e-52d74baa1femr319051921cf.22.1786891686398; 
 Sun, 16 Aug 2026 07:48:06 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999611bf65sm47666255e9.13.2026.08.16.07.48.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:48:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/56] hw/qdev: Parent device before setting parent bus
Date: Sun, 16 Aug 2026 16:45:14 +0200
Message-ID: <20260816144556.69009-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QsVuG1yd c=1 sm=1 tr=0 ts=6a81cda7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=jOmSDqYlwVm5XPtxtUUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 26-2n9bmBylwry_-kh1TAdPBiO6TFrzd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX+8FvqX0A7XCd
 HNYI8VdPN0FkeaONvHLyY+Lo/WwIdPrMEp4jcAv9Gje4KIiy9QeRcPdiPrH/LQfztqaA8Np2ew1
 qjx5iz3bkvTCinVsxC0lDNkvdvyNIL/Jr9+6qWk7W92vFCMdvCphjqTKjltlceo+FAA0Qgz2XRq
 oEz4RjFsOTUAyA/g7W4L18XpLTSD1/26YoV3piIifuHrxzj3rdoX/gEB4dlKU3ZcX6bXHbOoqNH
 cDeqgbrSiLLZlPfc0HIrn4cukLsmu+EioBvRfaDi+4zxKJ/Hn+4OgQuL1q0N9fBQbp9ZaBRXSqw
 39PTSrrT121IFf3BJ8/LPa86lHYpkxfGmZlnqFYeT7p9w9zIG6RRLwTmDHSAngUyzSqLsN8mARz
 Ltcx0eG8sDSNFou5fKVMmHQHYNl5qNKetr/YhR/eAZc0g9dLTEtz58WKUaCu2ELV4QUEDnihauZ
 ZvYdo+iLAtN1wEZpHEg==
X-Proofpoint-ORIG-GUID: 26-2n9bmBylwry_-kh1TAdPBiO6TFrzd
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX12y+v/rNTrRK
 +2aL7WEhZ9eKCNw/Orf79u3P/PTXjPMu5GtLUOLbOyZbfIhZeSLU7Eg5kDylmsY7ew7M71K+lW3
 lYJedniPKTjgevJ6Gtz/eBQyc+saLgs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160118
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Commit 9940b2cfbc05 ("qdev: New qdev_new(), qdev_realize(), etc.") says
"device state 'no QOM parent, but plugged into bus' is dangerous". In
such a case, unrealizing the bus will hang in bus_unparent():

    while ((kid = QTAILQ_FIRST(&bus->children)) != NULL) {
        DeviceState *dev = kid->child;
        object_unparent(OBJECT(dev));
    }

object_unparent() does nothing when its argument has no QOM parent,
and the loop spins forever.

However, that commit did not completely eliminate such a situation.
When the device is not parented, device_set_realized() lets
/machine/unattached parent it, but it happens after setting parent bus.
Therefore, any failure between the two operations can leave the device
in a dangerous state.

qdev_realize() at least asserts that the device is not already realized
and prevents one realization failure pattern, but it is not
comprehensive. Besides, it will trip with a command line like the
following:

    qemu-system-x86_64 -M none -nodefaults -nographic \
        -device ipmi-bmc-sim,realized=on

Eliminate the dangerous state by ensuring that the device is parented
before calling qdev_set_parent_bus(). Also, stop asserting that the
device is not already realized in qdev_realize(); it is broken and
no longer serves any purpose.

Fixes: 9940b2cfbc05 ("qdev: New qdev_new(), qdev_realize(), etc.")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260721-qdev-v3-14-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/core/qdev.c         | 51 ++++++++++++++++++++++++------------------
 tests/unit/test-qdev.c | 13 +++++++++++
 2 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index e2aab3d1fc6..0b0f2f47fa7 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -264,17 +264,43 @@ static void device_reset_child_foreach(Object *obj, ResettableChildCallback cb,
 
 bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
 {
-    assert(!dev->realized && !dev->parent_bus);
+    static int unattached_count;
+    bool unattached_parent = false;
+
+    assert(!dev->parent_bus);
+
+    if (!OBJECT(dev)->parent) {
+        gchar *name = g_strdup_printf("device[%d]", unattached_count++);
+
+        object_property_add_child(machine_get_container("unattached"),
+                                  name, OBJECT(dev));
+        unattached_parent = true;
+        g_free(name);
+    }
 
     if (bus) {
         if (!qdev_set_parent_bus(dev, bus, errp)) {
-            return false;
+            goto fail;
         }
     } else {
         assert(!DEVICE_GET_CLASS(dev)->bus_type);
     }
 
-    return object_property_set_bool(OBJECT(dev), "realized", true, errp);
+    if (object_property_set_bool(OBJECT(dev), "realized", true, errp)) {
+        return true;
+    }
+
+fail:
+    if (unattached_parent) {
+        /*
+         * Beware, this doesn't just revert
+         * object_property_add_child(), it also runs bus_remove()!
+         */
+        object_unparent(OBJECT(dev));
+        unattached_count--;
+    }
+
+    return false;
 }
 
 bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp)
@@ -479,8 +505,6 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
     BusState *bus;
     NamedClockList *ncl;
     Error *local_err = NULL;
-    bool unattached_parent = false;
-    static int unattached_count;
 
     if (dev->hotplugged && !dc->hotpluggable) {
         error_setg(errp, "Device '%s' does not support hotplugging",
@@ -493,15 +517,6 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
             goto fail;
         }
 
-        if (!obj->parent) {
-            gchar *name = g_strdup_printf("device[%d]", unattached_count++);
-
-            object_property_add_child(machine_get_container("unattached"),
-                                      name, obj);
-            unattached_parent = true;
-            g_free(name);
-        }
-
         hotplug_ctrl = qdev_get_hotplug_handler(dev);
         if (hotplug_ctrl) {
             hotplug_handler_pre_plug(hotplug_ctrl, dev, &local_err);
@@ -627,14 +642,6 @@ post_realize_fail:
 
 fail:
     error_propagate(errp, local_err);
-    if (unattached_parent) {
-        /*
-         * Beware, this doesn't just revert
-         * object_property_add_child(), it also runs bus_remove()!
-         */
-        object_unparent(OBJECT(dev));
-        unattached_count--;
-    }
 }
 
 static bool device_get_hotpluggable(Object *obj, Error **errp)
diff --git a/tests/unit/test-qdev.c b/tests/unit/test-qdev.c
index 20eae38e03f..77c3eee7171 100644
--- a/tests/unit/test-qdev.c
+++ b/tests/unit/test-qdev.c
@@ -78,6 +78,16 @@ static void test_qdev_free_properties(void)
     object_unref(mt);
 }
 
+static void test_qdev_double_realization(void)
+{
+    MyDev *mt = STATIC_TYPE(object_new(TYPE_MY_DEV));
+
+    qdev_realize(DEVICE(mt), NULL, &error_fatal);
+    qdev_realize(DEVICE(mt), NULL, &error_fatal);
+    object_unparent(OBJECT(mt));
+    object_unref(OBJECT(mt));
+}
+
 
 int main(int argc, char **argv)
 {
@@ -90,6 +100,9 @@ int main(int argc, char **argv)
     g_test_add_func("/qdev/free-properties",
                     test_qdev_free_properties);
 
+    g_test_add_func("/qdev/double-realization",
+                    test_qdev_double_realization);
+
     g_test_run();
 
     return 0;
-- 
2.53.0


