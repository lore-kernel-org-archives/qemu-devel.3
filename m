Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF080CD1288
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 03:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq3BP-0007vR-5I; Thu, 28 Mar 2024 23:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1rq3BN-0007uv-EA
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 23:45:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1rq3BL-00070X-3Z
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 23:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711683929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VdyyTcNkDbQcMt3hk5T8AQVMtPVQqupjlUcIYRBR2cI=;
 b=dCU36y7NvTnE5augfA3W7CS6KSAkvr9nRwm4GN97FMGQlh+QEkrkMuri3NSd+/56znipsc
 gtDyEg1wB5kouZPjO1XR8oBLGJxV2vOsSK5csoAFoGWvcQW4blFy79uHBFsVrFQRJqROlG
 01zVEsIpObbb0nEhsZHxzHyN3LbCoPU=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-0adf8Ny5MtaqGpsQ0oFhYw-1; Thu, 28 Mar 2024 23:45:26 -0400
X-MC-Unique: 0adf8Ny5MtaqGpsQ0oFhYw-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6dbd919aba8so316770b3a.0
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 20:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711683926; x=1712288726;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VdyyTcNkDbQcMt3hk5T8AQVMtPVQqupjlUcIYRBR2cI=;
 b=K7PDVPH9SEa46LTb3pu3I5PC1+DNO8dqKdBCcWMZOJ0YASPzJvc2huakBLMnmkeXZe
 rCotjA0LFsLMrSCbYJBjb9sqM20WUQ06oTWdEdoww9mmIFa6GDZNzfIxRIgKOlwklDnb
 NtZXV7WChhpoB8LAnNB+vkeexO9I6UzKBn/Vb9t+rkWQve5nxLa+LYqrnLmM/VxYPfTa
 rb/kTvCkvbZLYR4oIjpe6/XHo0m0eYo17RgCA3RsA42ShGEOR/SQkOkoV6Fw8p+hBGD3
 NzTg1d/St+Z0fys1GlCg+O252HLf3JSQJ1GFm8G8Rw7Td0pd5tX1DMXkmlKAAXFi3kwy
 L8gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsmgcIIuf/pyKzKuRxkpHDAQmvyD2Y8psp+JBPsqlNP6KRkzPERvcA2EoLa2BkilNyreInWAodtO7kmOllJlvVdlqr7Ng=
X-Gm-Message-State: AOJu0YxUPxhu0fMQkS/GoNBb7SL+GfQFS149VGcZQQKmpFRodaAbKe9i
 OEuF6N/gPvJGn9Xji0O3D/jNFzc34NAHAhVsaQkaYhwD5ophU3bRWqGF4rD7pwrestmWIhzzYKp
 f9mdtH2artBAaxSCkHiSmm5g/Iqk7l9CaRzffUV/iI5wdlCc6neRS
X-Received: by 2002:a05:6a00:198c:b0:6ea:ba47:a63b with SMTP id
 d12-20020a056a00198c00b006eaba47a63bmr1333613pfl.0.1711683925789; 
 Thu, 28 Mar 2024 20:45:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1FoE+ZIDAuKnYBSfurhdchpwpXgjke0/t+cMdsPn4minv8qJYLVuVrOZjJLrfqTLVOTmrCQ==
X-Received: by 2002:a05:6a00:198c:b0:6ea:ba47:a63b with SMTP id
 d12-20020a056a00198c00b006eaba47a63bmr1333592pfl.0.1711683925418; 
 Thu, 28 Mar 2024 20:45:25 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 e5-20020aa79805000000b006eac9c54f7csm2197966pfl.96.2024.03.28.20.45.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Mar 2024 20:45:25 -0700 (PDT)
Message-ID: <46f0c5ab-dee7-4cd4-844d-c418818e187c@redhat.com>
Date: Fri, 29 Mar 2024 11:45:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-arm@nongnu.org, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>
References: <20240312074849.71475-1-shahuang@redhat.com>
 <Zf2bbcpWYMWKZpNy@redhat.com>
 <1881554f-9183-4e01-8cda-0934f7829abf@redhat.com>
 <ZgE71v8uGDNihQ5H@redhat.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <ZgE71v8uGDNihQ5H@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Daniel,

On 3/25/24 16:55, Daniel P. Berrangé wrote:
> On Mon, Mar 25, 2024 at 01:35:58PM +0800, Shaoqin Huang wrote:
>> Hi Daniel,
>>
>> Thanks for your reviewing. I see your comments in the v7.
>>
>> I have some doubts about what you said about the QAPI. Do you want me to
>> convert the current design into the QAPI parsing like the
>> IOThreadVirtQueueMapping? And we need to add new json definition in the
>> qapi/ directory?

I have defined the QAPI for kvm-pmu-filter like below:

+##
+# @FilterAction:
+#
+# The Filter Action
+#
+# @a: Allow
+#
+# @d: Disallow
+#
+# Since: 9.0
+##
+{ 'enum': 'FilterAction',
+  'data': [ 'a', 'd' ] }
+
+##
+# @SingleFilter:
+#
+# Lazy
+#
+# @action: the action
+#
+# @start: the start
+#
+# @end: the end
+#
+# Since: 9.0
+##
+
+{ 'struct': 'SingleFilter',
+ 'data': { 'action': 'FilterAction', 'start': 'int', 'end': 'int' } }
+
+##
+# @KVMPMUFilter:
+#
+# Lazy
+#
+# @filter: the filter
+#
+# Since: 9.0
+##
+
+{ 'struct': 'KVMPMUFilter',
+  'data': { 'filter': ['SingleFilter'] }}

And I guess I can use it by adding code like below:

--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -1206,3 +1206,35 @@ const PropertyInfo 
qdev_prop_iothread_vq_mapping_list = {
      .set = set_iothread_vq_mapping_list,
      .release = release_iothread_vq_mapping_list,
  };
+
+/* --- kvm-pmu-filter ---*/
+
+static void get_kvm_pmu_filter(Object *obj, Visitor *v,
+        const char *name, void *opaque, Error **errp)
+{
+    KVMPMUFilter **prop_ptr = object_field_prop_ptr(obj, opaque);
+
+    visit_type_KVMPMUFilter(v, name, prop_ptr, errp);
+}
+
+static void set_kvm_pmu_filter(Object *obj, Visitor *v,
+        const char *name, void *opaque, Error **errp)
+{
+    KVMPMUFilter **prop_ptr = object_field_prop_ptr(obj, opaque);
+    KVMPMUFilter *list;
+
+    printf("running the %s\n", __func__);
+    if (!visit_type_KVMPMUFilter(v, name, &list, errp)) {
+        return;
+    }
+
+    printf("The name is %s\n", name);
+    *prop_ptr = list;
+}
+
+const PropertyInfo qdev_prop_kvm_pmu_filter = {
+    .name = "KVMPMUFilter",
+    .description = "der der",
+    .get = get_kvm_pmu_filter,
+    .set = set_kvm_pmu_filter,
+};

+#define DEFINE_PROP_KVM_PMU_FILTER(_name, _state, _field) \
+    DEFINE_PROP(_name, _state, _field, qdev_prop_kvm_pmu_filter, \
+                KVMPMUFilter *)

--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2439,6 +2441,7 @@ static Property arm_cpu_properties[] = {
                          mp_affinity, ARM64_AFFINITY_INVALID),
      DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
      DEFINE_PROP_INT32("core-count", ARMCPU, core_count, -1),
+    DEFINE_PROP_KVM_PMU_FILTER("kvm-pmu-filter", ARMCPU, kvm_pmu_filter),
      DEFINE_PROP_END_OF_LIST()
  };

And I guess I can use the new json format input like below:

qemu-system-aarch64 \
	-cpu host, '{"filter": [{"action": "a", "start": 0x10, "end": "0x11"}]}'

But it doesn't work. It seems like because the -cpu option doesn't 
support json format parameter.

Maybe I'm wrong. So I want to double check with if the -cpu option 
support json format nowadays?

If the -cpu option doesn't support json format, how I can use the QAPI 
for kvm-pmu-filter property?

Thanks,
Shaoqin

> 
> Yes, you would define a type in the qapi dir similar to how is
> done for IOThreadVirtQueueMapping, and then you can use that
> in the property setter method.
> 
> 
> With regards,
> Daniel

-- 
Shaoqin


