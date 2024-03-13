Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E56C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 10:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkMEJ-0002Gl-2d; Wed, 13 Mar 2024 06:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rkME7-0002Bz-SS
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:52:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rkME6-0006i5-3x
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710327169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EHltZ8szKnxCz2q/u8DbdAJB83VSOOzZu2DOlQUSNm8=;
 b=Nmp7uLvwYykuSjl0IjR28ucT1eW5MRIo8z+t7u3UygNS11GhtYmSt5tTk7mgeyEieDoWDB
 Y8kqEq+tvS7H/gTZNYLUsbZaMD08/cMnKGWEMZE/rlggTKlUsjHJtEXyhCJuTbPq+6mTi1
 Xxae5HqW3gZF84fkEdDlzTZaxXj31l4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-nwdfvUNxOyGQWN3EiRv6Vg-1; Wed, 13 Mar 2024 06:52:48 -0400
X-MC-Unique: nwdfvUNxOyGQWN3EiRv6Vg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33e1dcb31a8so371488f8f.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 03:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710327167; x=1710931967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EHltZ8szKnxCz2q/u8DbdAJB83VSOOzZu2DOlQUSNm8=;
 b=QEXH/i/zZOyQvuVh3IhiSyDhJfiuIE8ZnJcKwV4t4O01fIIBzfanqQqjTEJC6zP4Bs
 0kfSPzwHxYPOYSZWkJu0q34H8t0Vq8fk5wid/wSrJld7TOVHzKVqv7hbdc5DjAssnapn
 Dw1Sp6wu09708sb3zn1Mr6+qUVUreDGHbeEA113FtLt4ggvoF38PMLIwQ0GFf4qPngCI
 YROSDpIliWUDhXAner88/4HbuauYOWy47+BxyP39HxQCEXjPCMblugJzDpkBfy7svMCS
 wX/p2VUJ45JSW5GgXbH7Dk3BLbeV51LwIO4mjQpTyFqAUNi7qv/4Mz/sEBf9CMtWxahN
 hciQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc4lJYoGhZM1cAL8j5/oCPKOXKIUzHp/JnCfQW1DRlpSgPNlFXdJ6YaI3Y6Ef4zdMQE3vvDZHzhrT3RTIvdZJEvhY4wBM=
X-Gm-Message-State: AOJu0YwOmGsmM12LnL74oiSNyFP4qDfq0fK71CTx4cO+gWPauPe4NxlV
 wd58jMeBHlcKGVodcZcha7DusGNEqZRbFj6BqWyRxO7MaEpI4sCAuI+rIjHlPMQeMesLYV4MEmH
 veVzRLsrSSsC8sp4OjyB/z7jBL8ElUbum7M+p1AFVVHmkPcZ3vCVN+mVfKWcCtRsq287lk3g/sc
 7tX/+1Dr1JMzWa/MwEh5G32yhqEGg=
X-Received: by 2002:adf:e6c4:0:b0:33d:d865:3b91 with SMTP id
 y4-20020adfe6c4000000b0033dd8653b91mr1796701wrm.52.1710327166816; 
 Wed, 13 Mar 2024 03:52:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENNa4UA3kBKW+TISFwATyzLx3Vbb6wT8hLcf/HV3jXPRrJyC0Svf+N1xe/I0VK/KgZ8KTg8oM1hwNxRI+O/CY=
X-Received: by 2002:adf:e6c4:0:b0:33d:d865:3b91 with SMTP id
 y4-20020adfe6c4000000b0033dd8653b91mr1796678wrm.52.1710327166501; Wed, 13 Mar
 2024 03:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
 <20240306095407.3058909-4-zhao1.liu@linux.intel.com>
 <c2bd5503-7ab1-41b7-af81-2f5bf5992ad3@redhat.com>
 <Zesv4W8DKteGeE/a@intel.com>
 <CAE8KmOxHNTGkE-8Xd+RXOuHNmyHqPwU4HcYRO6qHBGVAy6nAew@mail.gmail.com>
 <Ze6UmDoFD5Qd8AC/@intel.com>
In-Reply-To: <Ze6UmDoFD5Qd8AC/@intel.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 13 Mar 2024 16:22:30 +0530
Message-ID: <CAE8KmOzwrLY5ag_FKvX-ovAopfPeYSqFHc3-sdQj_zt_28tH5A@mail.gmail.com>
Subject: Re: [PATCH 03/14] hw/core/machine-smp: Simplify variables'
 initialization in machine_parse_smp_config()
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, 
 Xiaoling Song <xiaoling.song@intel.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello Zhao,

> (Communicating with you also helped me to understand the QAPI related parts.)

* I'm also visiting QAPI code parts for the first time. Thanks to you. :)

On Mon, 11 Mar 2024 at 10:36, Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> SMPConfiguration is created and set in machine_set_smp().
> Firstly, it is created by g_autoptr(), and then it is initialized by
> visit_type_SMPConfiguration().
>
> The visit_type_SMPConfiguration() is generated by
> gen_visit_object_members() in scripts/qapi/visit.py.
>
> IIUC, in visit_type_SMPConfiguration() (let's have a look at
> gen_visit_object_members()), there's no explicit initialization of
> SMPConfiguration() (i.e., the parameter named "%(c_name)s *obj" in
> gen_visit_object_members()). For int type, has_* means that the field is
> set.
>

* Thank you for the above details, appreciate it. I added few
fprintf() calls to visit_type_SMPConfiguration() to see what user
values it receives
===
$ ./qemu-system-x86_64 -smp cores=2,maxcpus=2,cpus=1,sockets=2
visit_type_SMPConfiguration: name: smp
        has_cpus: 1:1
 has_drawvers: 0:0
      has_books: 0:0
  has_sockets: 1:2
        has_dies: 0:0
 has_clusters: 0:0
     has_cores: 1:2
  has_threads: 0:0
has_maxcpus: 1:2
qemu-system-x86_64: Invalid CPU topology: product of the hierarchy
must match maxcpus: sockets (2) * dies (1) * cores (2) * threads (0)
!= maxcpus (2)
===
* As seen above, undefined -smp fields (both has_xxxx and xxxx) are
set to zero(0).

===
main
 qemu_init
  qemu_apply_machine_options
   object_set_properties_from_keyval
    object_set_properties_from_qdict
     object_property_set
      machine_set_smp
       visit_type_SMPConfiguration
        visit_start_struct
(gdb) p v->start_struct
$4 = ... 0x5555570248e4 <qobject_input_start_struct>
(gdb)
(gdb)
 qobject_input_start_struct
   if (obj) {
        *obj = g_malloc0(size);
    }
===
* Stepping through function calls in gdb(1) revealed above call
sequence which leads to  'SMPConfiguration **'  objects allocation by
g_malloc0.

> This means if user doesn't initialize some field, the the value should
> be considerred as unreliable. And I guess for int, the default
> initialization value is the same as if we had declared a regular integer
> variable. But anyway, fields that are not explicitly initialized should
> not be accessed.

* g_malloc0() allocating 'SMPConfiguration **' object above assures us
that undefined -smp fields shall always be zero(0).

* 'obj->has_xxxx' field is set only if the user has supplied the
variable value, otherwise it remains set to zero(0).
   visit_type_SMPConfiguration_members
     ->visit_optional
       ->v->optional
        -> qobject_input_optional

* Overall, I think there is scope to simplify the
'machine_parse_smp_config()' function by using SMPConfiguration
field(s) ones.

Thank you.
---
  - Prasad


