Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C355C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 18:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBelY-0002ax-PK; Mon, 27 May 2024 14:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBelP-0002XS-26
 for qemu-devel@nongnu.org; Mon, 27 May 2024 14:08:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBelN-00050Z-Me
 for qemu-devel@nongnu.org; Mon, 27 May 2024 14:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716833279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0/JfH7N/nuQsv0uuev1kT0QoNsHUVcm2JXr2tqXefvc=;
 b=FllS8seDH83KOjG7A3dnC0+/rKV4ei1WYvrBCxc0r8utlbw9IMethwTCxDmB8h9m84rxz5
 jQeZYcQzivVQyWkK+qaMLdsGIQrPcENsz3elmhtQONb4Aip81kE6Q/C46gXrUHFPWYfJfm
 zBWhCiNPJq9HMEqWqJ0RU6P73Ia27Qc=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-1Q8hJac4OieBMhXXLc9o6g-1; Mon, 27 May 2024 14:07:56 -0400
X-MC-Unique: 1Q8hJac4OieBMhXXLc9o6g-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5b6ffbb727dso17176eaf.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 11:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716833275; x=1717438075;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0/JfH7N/nuQsv0uuev1kT0QoNsHUVcm2JXr2tqXefvc=;
 b=RdorMMZOl2WaGx/ugp9SyCQx1UElBYMiV8b8Yh8wwAugnmDjLL5gY223kmljx9VJ//
 vLAvQKmw6/Fk/yw8enZa9eGeNkNswbd3lGY3Ue0P4jHo/wkf+pwBX+EywI/MTdAgUV0W
 UwkftoPTRWDBhOjf+ojGPwHpqNRt8zK+/RwzT2Qc7rp5a0M47cNLMp0U2N0JF87SmE8L
 FifT4qARpqF+h6x8tgia1tXebq22Y2bRNI3MhKmijiDntuOMtdREL6MKREJ+1Om6wFzW
 o6JAvrwxy2owdm0Njd8A4T2YVzT4qWPfk+Bt+zbDJPP/Lqo9zY/qg1oIYIT6LFQEmypJ
 Yy/w==
X-Gm-Message-State: AOJu0Yy6epsj56MMAingyKj4FWYCaSrsNheKVHFUcEhEPNPettUMSAfv
 +AWPED6n/z7LFi4SVlBK4Ts9GpsAWRD8j1/720RcH3AVEREmFmxXZ5QnLsWt43joVkgY5e5tJto
 fG0YZ4w7r2KFp+emwmD8SpTxDADEGh0ngdX2zh9jr1thAKUEsB45J
X-Received: by 2002:a05:6358:895:b0:192:2be2:bd0 with SMTP id
 e5c5f4694b2df-197e4840f37mr1165049155d.0.1716833275030; 
 Mon, 27 May 2024 11:07:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ2GvtA3bpTg8jcWXgURjfy13gkQGzLhem5nuth3trX9GwkINfhPk0hGEkA3+nzMb3foekNw==
X-Received: by 2002:a05:6358:895:b0:192:2be2:bd0 with SMTP id
 e5c5f4694b2df-197e4840f37mr1165045855d.0.1716833274331; 
 Mon, 27 May 2024 11:07:54 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abd3716asm314428285a.125.2024.05.27.11.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 11:07:53 -0700 (PDT)
Date: Mon, 27 May 2024 14:07:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V1 00/26] Live update: cpr-exec
Message-ID: <ZlTL9vKRxrnK6RNB@x1n>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

On Mon, Apr 29, 2024 at 08:55:09AM -0700, Steve Sistare wrote:
> This patch series implements a minimal version of cpr-exec.  Future series
> will add support for:
>   * vfio
>   * chardev's without loss of connectivity
>   * vhost
>   * fine-grained seccomp controls
>   * hostmem-memfd
>   * cpr-exec migration test

Another request besides the questions I threw already.. could you push to a
tree where it has everything?  Maybe that'll help to review also the min set.

Thanks,

-- 
Peter Xu


