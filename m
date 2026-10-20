Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F72606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aanf2Mf7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ7UC-0005Op-VX; Tue, 20 Oct 2026 06:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ7Rp-00016e-PO
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:52:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ7Rm-0006fu-K7
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792493515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LYACgjhTWZ9q+fLhnzsamP9g+AzKgXq2yAfu5fEslcg=;
 b=aanf2Mf7GTaqdeppr2099HyhO9I/TSgix+uC+WtKZV2G8B6Kmdc7XEbSim7JOqlhC/6Ee7
 K+eG0nFiK/NUTA/b80rr8zIsGdF19H1FD4YKd+YjdHzQUQHy1fsdEVjhdRSNwbxj1LiUjO
 ApO0yCl0V+8Vq3W+7VIwWrSWc79xMf0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-wz3IHZmqNpWyL00b1VAr7Q-1; Tue,
 20 Oct 2026 10:51:46 +0000
X-MC-Unique: wz3IHZmqNpWyL00b1VAr7Q-1
X-Mimecast-MFC-AGG-ID: wz3IHZmqNpWyL00b1VAr7Q_1792493502
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 390C7180132B; Tue, 20 Oct 2026 10:51:42 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AEC3230000E7; Tue, 20 Oct 2026 10:51:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 20 Oct 2026 14:46:18 +0400
Subject: [PATCH v7 61/65] qdev: remove deprecated PropertyInfo.type and
 .enum_table fields
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261020-qom-qapi-v7-61-431a86b02b58@redhat.com>
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
In-Reply-To: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, John Snow <jsnow@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>, 
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org, Alberto Garcia <berto@igalia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
 Junjie Cao <junjie.cao@intel.com>, Anisa Su <anisa.su@samsung.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, 
 John Levon <john.levon@nutanix.com>, 
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-block@nongnu.org, 
 linux-cxl@vger.kernel.org, qemu-s390x@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>, 
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>, 
 Xianglai Li <lixianglai@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Alistair Francis <alistair@alistair23.me>, Alexander Graf <graf@amazon.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, Ani Sinha <anisinha@redhat.com>, 
 Luc Michel <luc@lmichel.fr>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Samuel Tardieu <sam@rfc1149.net>, "Denis V. Lunev" <den@openvz.org>, 
 FangSheng Huang <FangSheng.Huang@amd.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Aditya Gupta <adityag@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Conor Dooley <conor@kernel.org>, 
 Sebastian Huber <sebastian.huber@embedded-brains.de>, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Titus Rwantare <titusr@google.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, Peter Xu <peterx@redhat.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, 
 Hendrik Brueckner <brueckner@linux.ibm.com>, xen-devel@lists.xenproject.org, 
 Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Fam Zheng <fam@euphon.net>, 
 Farhan Ali <alifm@linux.ibm.com>, Alex Williamson <alex@shazbot.org>, 
 Tao Tang <tangtao1634@phytium.com.cn>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, Jiri Pirko <jiri@resnulli.us>, 
 Eric Auger <eric.auger@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5656;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=GW0iWX+ovnUEAGVG0BxcFS64OjWdn47qGiXFBFBt6kE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq10ZduD65Qr6F408CFXCHRwiWcGKpWuyckav27
 m0L7FlHyHOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatdGXQAKCRDa6OEJdZac
 5SIyD/9K494S/RKkzAsSOv9T/MgMAP/WgYu11N3TAUAFlouXn2Swjs8mxH+DvN0TL1zOI7DEln4
 fWF3jd4K9yGpeOdK3FVhlUuUGIu+vCahmXGsC2IRNnSgUJb4k2RHjeIiyWV/jhtNA/9wx465q/C
 0OSjxbW+EtYZ3lz0RkjF6YDM+tm9WVYqnQnMDbFuzngcpgqksdveXP06Xu2THNHykMaEy9m8nir
 mzxnTI67NabjcysMX+MF1Qgy6e2kI6X8PSi5Ii4CpJXlg6NszHB8aISyuxGh3En/Fv2Y/2f/fzC
 sIKxBFBcSVSMYhRpwzAZZCX8YSUbh2Y42NRkfwZMI08gHA+sl8pYFdenolCBtd8mEDlWjtCWGLB
 c97FNo8YgEqQpDTNZOal6LhBdRktum+TSi1XlcqMndZ/TCO/g5x8g/hnsFrp/+6WHt+4VAegrzT
 mkGeBr/Y+ok5ueSlc+kTZYEoLpKHAsHeYM3r+GcPnXOgCk9GvkOrAfaAoHc155+qqmkOyAUeWJu
 V4X338aVVee/lykp8yDDcAkwPVhw1DH0lCRXuHCA2/aR8xhiZg8zMindNp8TtG/QbTUCwDa/WMw
 hJcKbcWKMOqkjIZn3eNTlzVwzpE6SFeoKKAnXaQFooDRlL0a/mAzPqJ1ahGBT4iLEdc/AVpxjkM
 ETt5bqcvNS2VmlQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Now that all PropertyInfo definitions use .qapi_type, remove the
legacy .type (string) and .enum_table fields from PropertyInfo, and
the .arrayinfo/.arrayfieldsize fields from Property.

Remove fallback branches in qdev_property_add_static() and
qdev_class_add_property() that used object_property_add() with
prop->info->type: these always use the QAPI-aware registration
path now. Simplify qdev_propinfo_enum_lookup(), prop_array_info()
and prop_array_elem_size() to use the new fields directly.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/qdev-properties.c         | 58 ++++++++++++---------------------------
 include/hw/core/qdev-properties.h |  4 ---
 2 files changed, 17 insertions(+), 45 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 5c403cc2e57e..a121878467e1 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -103,11 +103,8 @@ static ObjectPropertyAccessor *field_prop_setter(const PropertyInfo *info)
 
 const QEnumLookup *qdev_propinfo_enum_lookup(const PropertyInfo *info)
 {
-    if (info->qapi_type) {
-        assert(info->qapi_type->lookup);
-        return info->qapi_type->lookup;
-    }
-    return info->enum_table;
+    assert(info->qapi_type->lookup);
+    return info->qapi_type->lookup;
 }
 
 void qdev_propinfo_get_enum(Object *obj, Visitor *v, const char *name,
@@ -668,18 +665,12 @@ struct ArrayElementList {
 
 static const PropertyInfo *prop_array_info(const Property *prop)
 {
-    if (prop->info->element_info) {
-        return prop->info->element_info;
-    }
-    return prop->arrayinfo;
+    return prop->info->element_info;
 }
 
 static int prop_array_elem_size(const Property *prop)
 {
-    if (prop->info->element_size) {
-        return prop->info->element_size;
-    }
-    return prop->arrayfieldsize;
+    return prop->info->element_size;
 }
 
 /*
@@ -1224,20 +1215,13 @@ void qdev_property_add_static(DeviceState *dev, const Property *prop)
     const QAPITypeInfo *qapi_type = qdev_prop_qapi_type(prop);
 
     assert(!prop->info->create);
+    assert(qapi_type);
 
-    if (qapi_type) {
-        op = object_property_add_qapi(obj, prop->name, qapi_type,
-                                      field_prop_getter(prop->info),
-                                      field_prop_setter(prop->info),
-                                      prop->info->release,
-                                      (Property *)prop);
-    } else {
-        op = object_property_add(obj, prop->name, prop->info->type,
-                                 field_prop_getter(prop->info),
-                                 field_prop_setter(prop->info),
-                                 prop->info->release,
-                                 (Property *)prop);
-    }
+    op = object_property_add_qapi(obj, prop->name, qapi_type,
+                                  field_prop_getter(prop->info),
+                                  field_prop_setter(prop->info),
+                                  prop->info->release,
+                                  (Property *)prop);
 
     object_property_set_description(obj, prop->name,
                                     prop->info->description);
@@ -1261,21 +1245,13 @@ static void qdev_class_add_property(DeviceClass *klass, const char *name,
     } else {
         const QAPITypeInfo *qapi_type = qdev_prop_qapi_type(prop);
 
-        if (qapi_type) {
-            op = object_class_property_add_qapi(oc,
-                                               name, qapi_type,
-                                               field_prop_getter(prop->info),
-                                               field_prop_setter(prop->info),
-                                               prop->info->release,
-                                               (Property *)prop);
-        } else {
-            op = object_class_property_add(oc,
-                                           name, prop->info->type,
-                                           field_prop_getter(prop->info),
-                                           field_prop_setter(prop->info),
-                                           prop->info->release,
-                                           (Property *)prop);
-        }
+        assert(qapi_type);
+        op = object_class_property_add_qapi(oc,
+                                            name, qapi_type,
+                                            field_prop_getter(prop->info),
+                                            field_prop_setter(prop->info),
+                                            prop->info->release,
+                                            (Property *)prop);
     }
     if (prop->set_default) {
         prop->info->set_default_value(op, prop);
diff --git a/include/hw/core/qdev-properties.h b/include/hw/core/qdev-properties.h
index 39f95ce7a3c6..2267e734d1fd 100644
--- a/include/hw/core/qdev-properties.h
+++ b/include/hw/core/qdev-properties.h
@@ -23,17 +23,13 @@ struct Property {
         int64_t i;
         uint64_t u;
     } defval;
-    const PropertyInfo *arrayinfo;
     int          arrayoffset;
-    int          arrayfieldsize;
     uint8_t      bitnr;
     bool         set_default;
 };
 
 struct PropertyInfo {
-    const char *type;
     const char *description;
-    const QEnumLookup *enum_table;
     const QAPITypeInfo *qapi_type;
     const struct PropertyInfo *element_info;
     int element_size;

-- 
2.56.0.116.g6de20f6092dc


