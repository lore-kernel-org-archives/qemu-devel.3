Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82313D767F9
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 19:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6akK-0003E6-Ko; Thu, 31 Oct 2024 15:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6akI-0003D6-JX
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 15:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6akH-00008O-6x
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 15:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730402532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kjGmsAZs1FR/ro2wyiwzKFCu0lf+ObdumaMDj4B7VUg=;
 b=ZUQe3htMdSFK47rzWzjzwkE/9X6okR0XPfjlbyJvQ5K2RFmw56L/jMaoNvN27q1HONchg6
 EYqUTxchpi6WZxYdQhyXPuXvtQl4VLhV92GPF0x3Yvl/N9T8/ZOg/XiC8ja2nfx8Qu6z/6
 YEfxrfu92alnuU8ZUSo+sulpY7roRyk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-RxvY1RFNM7SBiAHinQLguw-1; Thu, 31 Oct 2024 15:22:10 -0400
X-MC-Unique: RxvY1RFNM7SBiAHinQLguw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b17d635be6so177718685a.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 12:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730402530; x=1731007330;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kjGmsAZs1FR/ro2wyiwzKFCu0lf+ObdumaMDj4B7VUg=;
 b=lpyikVdh3Yam+czUFzmbnnV4JKE21XFAIDKU66zL3WXGK9uL562LNB8AacXCInz2Sw
 wD+HdXS3vVlZwkfhp0lOrAYZrnZusa0BeQ1rrUdRpouoBaQwN0nSu9yfP0J0GivyapjV
 Ec4o88TSzuOZqxj9s1/T1HhAyT33OPYj0ucYb/mT6PVUhWTbaI2Ayr79nV+aWAJiH9/U
 CNcRN6MZBwpUGe1nnCmpsuKGEnOoQJ24eywc4xyK7LpcLGvjZ3iuLEmzZDZEE4dTtAue
 CjVQaxHP1MwU9e1/Of4Ev2BYOvwSvJsQe3e7JsX14ZYteiX1Q06jxxjpxB9AW/TyJU/u
 sbGQ==
X-Gm-Message-State: AOJu0YwjsgMH5oxcdPBVn5Qkb1PN9nEpgTxTPIFRvqK9PIuEkS9bvWAQ
 6/EbzTdysJi1MY0bc6RayRx7MYBR2aWbgnXoxyuPGFJXhVFiB5g15UZwqIJGFi9u6uoM0VJg+qi
 RyYiGfAXVnZm4OlemkK7RxRZrSlZinEX68lYFd5WcitTTAkjilSy2
X-Received: by 2002:a05:620a:2903:b0:7a3:5f3f:c084 with SMTP id
 af79cd13be357-7b1aedb97c1mr1136117885a.30.1730402530146; 
 Thu, 31 Oct 2024 12:22:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmpDybqsOdmlRTQ2HqlHAAWJd5uCD/+Aa2pl2Tg4bBUzIZJn1RCUs+FEgGSmeklONzQTFHDA==
X-Received: by 2002:a05:620a:2903:b0:7a3:5f3f:c084 with SMTP id
 af79cd13be357-7b1aedb97c1mr1136115385a.30.1730402529782; 
 Thu, 31 Oct 2024 12:22:09 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a83159sm97874685a.116.2024.10.31.12.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 12:22:09 -0700 (PDT)
Date: Thu, 31 Oct 2024 15:22:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC 4/5] qom: introduce object_new_dynamic()
Message-ID: <ZyPY3_b1xmiB55H6@x1n>
References: <20241031155350.3240361-1-berrange@redhat.com>
 <20241031155350.3240361-5-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241031155350.3240361-5-berrange@redhat.com>
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

On Thu, Oct 31, 2024 at 03:53:49PM +0000, Daniel P. Berrangé wrote:
> object_new() has a failure scenario where it will assert() if given
> an abstract type. Callers which are creating objects based on user
> input, or unknown/untrusted type names, must manually check the
> result of object_class_is_abstract() before calling object_new()
> to propagate an Error, instead of asserting.
> 
> Introduce a object_new_dynamic() method which is a counterpart to
> object_new() that directly returns an Error, instead of asserting.
> This new method is to be used where the typename is specified
> dynamically by code separate from the immediate caller.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Needs some patch order changes.. v.s. the previous one.

Thanks,

-- 
Peter Xu


