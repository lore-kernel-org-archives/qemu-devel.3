Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391E3D767FB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 19:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6b8J-00052f-EY; Thu, 31 Oct 2024 15:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6b8I-00052X-8A
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 15:47:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6b8G-0003tE-5n
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 15:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730404018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sD5p/eDpoOVuTsX7SkV2yiIA9HLXjEXCWo1hCCRiTlU=;
 b=Q8eTiuqNNeLliR+cfwR6M4YDTCXbHRGo5m3+fDvCfDY5BOYyfOzuyZq2lN4dVBltNEPPjE
 6ypfJLiICfRn1Sc2JxMwomkQ8Iqs9Colh38bp4ZCLmMX+9gJnE7itG+MkwOz9be6QUo2jL
 dWXIiPlvByc3TTbjpzQprb38rg+tfuQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-jklsChjINOOUtdjWLmgmmg-1; Thu, 31 Oct 2024 15:46:56 -0400
X-MC-Unique: jklsChjINOOUtdjWLmgmmg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b14538be1eso173508685a.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 12:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730404016; x=1731008816;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sD5p/eDpoOVuTsX7SkV2yiIA9HLXjEXCWo1hCCRiTlU=;
 b=DyK0uD1zFTvux2GyOoBKCe/w5m/XLnhMBlicbWyrlruVstDCCTiRiU4v5b86e/BJZO
 F599FTm6lsrM2gr6OV/DCXKuGm5OI/4DMXTXqTx+7i3DXgEMrtotUuXl261Ur3yAqIZY
 2xr3IZyru9pRaGedPTwyuhcRMUSW6vQEaWubFVNe3cyKUg5mhhAVioJFmevTjJtve08N
 hY7Tuef0vMkRAOvNoDUuLHHm3typceJiUC49gwgoVzWsH8AlmS+9IgvPtiPp/29hhTon
 oauQEgFMxNM5e6tEb/37bcL3gVA6UzlHSUlfa2UNgAtfmv2TANF12yf/7y8vVmb/g6Uq
 ftNQ==
X-Gm-Message-State: AOJu0YwGsxGL1LwIv1KaEqsKIbB0UYmuiJ6FaHaqbSgtyXIWQ6C8VRwM
 G/Djd+BGxqih0mk/UmNzG7nKi7IN4nxy1XXQLYEQUewoia5Nu/1wIzGVsMZxvzvCPGigNIfJtQf
 0FKRvWilgIR6Msqp+tTYofZmtn0L5JdeckX6YO6vGujQdn5NcPKhK
X-Received: by 2002:a05:620a:4248:b0:7b1:4077:4935 with SMTP id
 af79cd13be357-7b2f2551594mr565452085a.56.1730404016372; 
 Thu, 31 Oct 2024 12:46:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbBb4p63a2LKtu0wtJg4DkPmzr+b25g0hDknFRB+aG0FT43u9gSby2RwUsqb7jrpmmwVUWyQ==
X-Received: by 2002:a05:620a:4248:b0:7b1:4077:4935 with SMTP id
 af79cd13be357-7b2f2551594mr565449885a.56.1730404016021; 
 Thu, 31 Oct 2024 12:46:56 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a7139fsm101181585a.76.2024.10.31.12.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 12:46:55 -0700 (PDT)
Date: Thu, 31 Oct 2024 15:46:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC 0/5] RFC: require error handling for dynamically created
 objects
Message-ID: <ZyPeq-vVmK1-fG3L@x1n>
References: <20241031155350.3240361-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241031155350.3240361-1-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
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

On Thu, Oct 31, 2024 at 03:53:45PM +0000, Daniel P. Berrangé wrote:
> With code like
> 
>     Object *obj = object_new(TYPE_BLAH)
> 
> the caller can be pretty confident that they will successfully create
> an object instance of TYPE_BLAH. They know exactly what type has been
> requested, so it passing an abstract type for example, it is a clear
> programmer error that they'll get an assertion failure.
> 
> Conversely with code like
> 
>    void somefunc(const char *typename) {
>       Object * obj = object_new(typename)
>       ...
>    }
> 
> all bets are off, because the call of object_new() knows nothing
> about what 'typename' resolves to. It could easily be an abstract
> type. As a result, many code paths have added a manual check ahead
> of time
> 
>    if (object_class_is_abstract(typename)) {
>       error_setg(errp, ....)
>    }
> 
> ...except for where we forget to do this, such as qdev_new().
> 
> Overall 'object_new' is a bad design because it is inherantly
> unsafe to call with unvalidated typenames.
> 
> This problem is made worse by the proposal to introduce the idea
> of 'singleton' classes[1].
> 
> Thus, this series suggests a way to improve safety at build
> time. The core idea is to allow 'object_new' to continue to be
> used *if-and-only-if* given a static, const string, because that
> scenario indicates the caller is aware of what type they are
> creating at build time.
> 
> A new 'object_new_dynamic' method is proposed for cases where
> the typename is dynamically chosen at runtime. This method has
> an "Error **errp" parameter, which can report when an abstract
> type is created, leaving the assert()s only for scenarios which
> are unambiguous programmer errors.
> 
> With a little macro magic, we guarantee a compile error is
> generated if 'object_new' is called with a dynamic type, forcing
> all potentially unsafe code over to object_new_dynamic.
> 
> This is more tractable than adding 'Error **errp' to 'object_new'
> as only a handful of places use a dynamic type name.
> 
> NB, this is an RFC as it is not fully complete.
> 
>  * I have only converted  enough object_new -> object_new_dynamic
>    to make the x86_64-softmu target compile. It probably fails on
>    other targets.
> 
>  * I have not run any test suites yet, so they may or may not pass
> 
>  * I stubbed qdev_new to just pass &error_fatal. qdev_new needs
>    the same conceptual fix to introcce qdev_new_dynamic with
>    the macro magic to force its use

I suppose this is the only missing path in my patch 1 in qdev_new()..

Even if we don't convert all of them, at least we can still convert the
easiest (qdev_device_add_from_qdict()) so as to drop the abstract check in
qdev_get_device_class().

The other one we can drop already after this series applied is the one in
char_get_class().  I think after that, all explicit abstract checks for
for object instantiations should be all gone.

-- 
Peter Xu


