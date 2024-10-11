Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D540FD0EE19
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJEX-0002Ph-Il; Fri, 11 Oct 2024 13:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1szJ7c-0000hD-QQ
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:08:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1szEgC-000611-Dw
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 08:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728649415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FwsG+zxJqCfI/+5mXoG0H64OBzq0JIZt/J5pk33CWe8=;
 b=BGOF5SBEdnEYehBe9Bl+Xn8opEYs6TNgux8AD6Eh8OxJwb7plNizJXSTkJsk/joqtU3NiW
 XK7oDqHNnWsQdq5uqrR3DoFTLpUGjnYtergz4RgWw4Nwgc6Qak47E7K3mseHPlcadolD42
 RgsU1x8G+9Dz+RwYHfoiCE4GF6Sp89s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-Q6xzzbVnPGea_nV6GTK4Qw-1; Fri, 11 Oct 2024 08:23:33 -0400
X-MC-Unique: Q6xzzbVnPGea_nV6GTK4Qw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43114c47615so9925645e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 05:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728649413; x=1729254213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FwsG+zxJqCfI/+5mXoG0H64OBzq0JIZt/J5pk33CWe8=;
 b=sicQupzafAkC+AO2UaYTqa2DRrTItHPjyv/TmqcTT/IFjajuyBCEJyPshn6BHvSRYu
 3jCOXTl6dmrzGPBjQ7IP8LqtKC0u9sWgzd1MsplGMBEtuA2pD3yOmMJUPzx+HRbmY2nV
 794ZV6aywNijLOwvq+8kb8IOW6RD4J3LUEfS94dA06cHuW7Z5ByvX7acNdb9X9tSBaNx
 B34wQXlShRc3yxFLTyS4NqjZhAmt/kEdM9MiiIHOwBNWSHouiEy1iQ5ZNzbXyKFO+hsg
 02ctl4EgUBt+XFGWJYT3Qp1kwJQROK1EP1vxsIk/G898BYCNwg6zP04J7/vV2nInTEsc
 yqNA==
X-Gm-Message-State: AOJu0Yz95fEp+OgHpyp/FrJZSHD6EJGLoPaBtq0I/upgjxGkjRviuw2b
 t7l8JeCOtMScb8WSAEiLkZHTnWMp/y0O/Nygi7D13dtaRbRRFjT0mgxBETtDFsK3pLrPHLir/sg
 4lyhLljM64TdXxwXI2w1o9eKtD0XNQFfxmHcBmFY5a0+0jkkbgmzt
X-Received: by 2002:a05:600c:4fd4:b0:431:144e:4f2f with SMTP id
 5b1f17b1804b1-4311deec326mr17164135e9.19.1728649412574; 
 Fri, 11 Oct 2024 05:23:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSJ0eE6VxkcFykeDIKAKfczSgDkoNfMUZh3sgx8qgeploBwPezjZ1Wtfn0yih7rZoWPJ+F3Q==
X-Received: by 2002:a05:600c:4fd4:b0:431:144e:4f2f with SMTP id
 5b1f17b1804b1-4311deec326mr17163855e9.19.1728649412097; 
 Fri, 11 Oct 2024 05:23:32 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431183062b5sm40718705e9.26.2024.10.11.05.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 05:23:31 -0700 (PDT)
Date: Fri, 11 Oct 2024 14:23:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, xieyongji@bytedance.com, kwolf@redhat.com,
 hreitz@redhat.com, Coiby.Xu@gmail.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, mark.cave-ayland@ilande.co.uk,
 michael.roth@amd.com, kkostiuk@redhat.com, qemu-block@nongnu.org,
 philmd@linaro.org
Subject: Re: [PATCH v2 4/7] target/i386/cpu: Avoid mixing signed and
 unsigned in property setters
Message-ID: <20241011142330.4d0bf59c@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241010150144.986655-5-armbru@redhat.com>
References: <20241010150144.986655-1-armbru@redhat.com>
 <20241010150144.986655-5-armbru@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 10 Oct 2024 17:01:41 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Properties "family", "model", and "stepping" are visited as signed
> integers.  They are backed by bits in CPUX86State member
> @cpuid_version.  The code to extract and insert these bits mixes
> signed and unsigned.  Not actually wrong, but avoiding such mixing is
> good practice.
> 
> Visit them as unsigned integers instead.
> 
> This adds a few mildly ugly cast in arguments of error_setg().  The
> next commit will get rid of them again.
> 
> Property "tsc-frequency" is also visited as signed integer.  The value
> ultimately flows into the kernel, where it is 31 bits unsigned.  The
> QEMU code freely mixes int, uint32_t, int64_t.  I elect not to attempt
> draining this swamp today.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  target/i386/cpu.c | 45 +++++++++++++++++++++------------------------
>  1 file changed, 21 insertions(+), 24 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index ff227a8c5c..4f8fa60432 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5433,13 +5433,13 @@ static void x86_cpuid_version_get_family(Object *obj, Visitor *v,
>  {
>      X86CPU *cpu = X86_CPU(obj);
>      CPUX86State *env = &cpu->env;
> -    int64_t value;
> +    uint64_t value;
>  
>      value = (env->cpuid_version >> 8) & 0xf;
>      if (value == 0xf) {
>          value += (env->cpuid_version >> 20) & 0xff;
>      }
> -    visit_type_int(v, name, &value, errp);
> +    visit_type_uint64(v, name, &value, errp);
>  }
>  
>  static void x86_cpuid_version_set_family(Object *obj, Visitor *v,
> @@ -5448,16 +5448,15 @@ static void x86_cpuid_version_set_family(Object *obj, Visitor *v,
>  {
>      X86CPU *cpu = X86_CPU(obj);
>      CPUX86State *env = &cpu->env;
> -    const int64_t min = 0;
> -    const int64_t max = 0xff + 0xf;
> -    int64_t value;
> +    const uint64_t max = 0xff + 0xf;
> +    uint64_t value;
>  
> -    if (!visit_type_int(v, name, &value, errp)) {
> +    if (!visit_type_uint64(v, name, &value, errp)) {
>          return;
>      }
> -    if (value < min || value > max) {
> +    if (value > max) {
>          error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE, "",
> -                   name ? name : "null", value, min, max);
> +                   name ? name : "null", value, (int64_t)0, (int64_t)max);
>          return;
>      }
>  
> @@ -5475,11 +5474,11 @@ static void x86_cpuid_version_get_model(Object *obj, Visitor *v,
>  {
>      X86CPU *cpu = X86_CPU(obj);
>      CPUX86State *env = &cpu->env;
> -    int64_t value;
> +    uint64_t value;
>  
>      value = (env->cpuid_version >> 4) & 0xf;
>      value |= ((env->cpuid_version >> 16) & 0xf) << 4;
> -    visit_type_int(v, name, &value, errp);
> +    visit_type_uint64(v, name, &value, errp);
>  }
>  
>  static void x86_cpuid_version_set_model(Object *obj, Visitor *v,
> @@ -5488,16 +5487,15 @@ static void x86_cpuid_version_set_model(Object *obj, Visitor *v,
>  {
>      X86CPU *cpu = X86_CPU(obj);
>      CPUX86State *env = &cpu->env;
> -    const int64_t min = 0;
> -    const int64_t max = 0xff;
> -    int64_t value;
> +    const uint64_t max = 0xff;
> +    uint64_t value;
>  
> -    if (!visit_type_int(v, name, &value, errp)) {
> +    if (!visit_type_uint64(v, name, &value, errp)) {
>          return;
>      }
> -    if (value < min || value > max) {
> +    if (value > max) {
>          error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE, "",
> -                   name ? name : "null", value, min, max);
> +                   name ? name : "null", value, (int64_t)0, (int64_t)max);
>          return;
>      }
>  
> @@ -5511,10 +5509,10 @@ static void x86_cpuid_version_get_stepping(Object *obj, Visitor *v,
>  {
>      X86CPU *cpu = X86_CPU(obj);
>      CPUX86State *env = &cpu->env;
> -    int64_t value;
> +    uint64_t value;
>  
>      value = env->cpuid_version & 0xf;
> -    visit_type_int(v, name, &value, errp);
> +    visit_type_uint64(v, name, &value, errp);
>  }
>  
>  static void x86_cpuid_version_set_stepping(Object *obj, Visitor *v,
> @@ -5523,16 +5521,15 @@ static void x86_cpuid_version_set_stepping(Object *obj, Visitor *v,
>  {
>      X86CPU *cpu = X86_CPU(obj);
>      CPUX86State *env = &cpu->env;
> -    const int64_t min = 0;
> -    const int64_t max = 0xf;
> -    int64_t value;
> +    const uint64_t max = 0xf;
> +    uint64_t value;
>  
> -    if (!visit_type_int(v, name, &value, errp)) {
> +    if (!visit_type_uint64(v, name, &value, errp)) {
>          return;
>      }
> -    if (value < min || value > max) {
> +    if (value > max) {
>          error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE, "",
> -                   name ? name : "null", value, min, max);
> +                   name ? name : "null", value, (int64_t)0, (int64_t)max);
>          return;
>      }
>  


