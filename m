Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131B7C54735
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 11:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sitvn-0008Rn-Gq; Tue, 27 Aug 2024 07:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sitvj-0008QB-8r
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:00:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sitvg-0006nK-V6
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 07:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724756399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EjOfHSQJC3KfNKsQCmkqko8PxTMgj0O+K0gdist8xPk=;
 b=NzPTmGk0d6o8YA24Q4xn2PthhtqjPJu3NRR99ljRA4o8COc88tohFO/SnNl7gwUkMUgg8R
 1KHQZp8OI/TMUxOvT6vYffXg9dRsw8ZKmwJNMnEUa3JswndXw6BjEEAEXgqNUzfgNit2oo
 A4X+B5YeF0tLngZdhztPChUlb+5g9dE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-hhtGqSnvMqO_OF_CzP-a_A-1; Tue, 27 Aug 2024 06:59:58 -0400
X-MC-Unique: hhtGqSnvMqO_OF_CzP-a_A-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42816096cb8so58807445e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 03:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724756397; x=1725361197;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EjOfHSQJC3KfNKsQCmkqko8PxTMgj0O+K0gdist8xPk=;
 b=Ro5lbqepI/h5nzDbuiHftZj3j4ViYjVjbGkl2i6h3XDBJqGpf4VVCagaqTSLQLD7k6
 FNDgzVoRaWp9RA+yW7U5kphtgdIJBULh5KqtbhnY3I0/zeZuBP7ZPHAnLMrr8Q3HJeDs
 HU/JCWwhbtmM4/dfP6HHSwznTX0x6V7NMiAE3ggAZ0KUc4ecZIXJvka9B/pK9mfyOr2t
 9iwXHFpt4KG+48qvm0cYdzPjcpWjWAdhgAn4HjPoAtP1q7tv41zXOugEv4xoO0sxGQxL
 Ex39zLKObY89SjoWeZeXB+B0g+VoWNlO3uNxQz0aZxL21KO0YjNoyOi78HFMJJ4niKM9
 /Lgw==
X-Gm-Message-State: AOJu0YzMRnZcgwf92SIBotUTMzHOl+pRJDjDTGR2Wu6XeoNMbYmL1i0Z
 nqVRDaaZD5RIWWL/s9Cl76omvDMF7qYV5UrdtbFnRm7PLPelZAzOtO2nt0YjxySX6ywvToub9qT
 8gRKgjjs3kIrtHKHnYj1A7gx+oqcdRnF0m2j6FVNgg0sJt63Vl2BDKt25lC/+dH6+LArxFUcMsT
 WezEJtMIPp7MGJpypqeAKebVmYTLE=
X-Received: by 2002:a05:600c:3152:b0:426:59fe:ac27 with SMTP id
 5b1f17b1804b1-42acd5dcce8mr108928345e9.26.1724756396783; 
 Tue, 27 Aug 2024 03:59:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTVpSdeegiC6NqVUZL7sh/v4U8qpyoILNMqDPovjuG6uIYCy86LKmyHCbAxSIDt2ixENlLYBjeW0TVJz70o2M=
X-Received: by 2002:a05:600c:3152:b0:426:59fe:ac27 with SMTP id
 5b1f17b1804b1-42acd5dcce8mr108928045e9.26.1724756396279; Tue, 27 Aug 2024
 03:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240808095147.291626-3-ppandit@redhat.com>
 <20240819120248.170180-1-ppandit@redhat.com>
 <20240819114137-mutt-send-email-mst@kernel.org>
 <20240819114959-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240819114959-mutt-send-email-mst@kernel.org>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 27 Aug 2024 16:29:39 +0530
Message-ID: <CAE8KmOx1FBZ3PP0uRkLJBQbAfvBGeT1NefKwiRBOezV-dGW_Kg@mail.gmail.com>
Subject: Re: [RFC-PATCH v2] vhost-user: add a request-reply lock
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, jasowang@redhat.com, 
 mcoqueli@redhat.com, peterx@redhat.com, pjp@fedoraproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hello Michael, all

Sorry about a late reply,  catching up with emails after long PTOs.

On Mon, 19 Aug 2024 at 21:20, Michael S. Tsirkin <mst@redhat.com> wrote:
>> makes sense.
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>> But do not post v2 as reply to v1 pls.

* Yes, okay. Thank you for the review. I sent in reply to v1 because
this is a 'RFC' thread and there was no review yet to this series.

* If  this V2 patch looks reasonable/acceptable, I'll send this series
for review (without RFC) as V2, if that's okay.

>> Also, looks like this will replace Message-Id: <20240801124540.38774-1-xiangwencheng@dayudpu.com> correct?

* Going through the git logs, vhost_user_set_log_base() sends set log
message only when vq_index==0, so the above patch is not required
IIUC.
    -> https://github.com/qemu/qemu/commit/c98ac64cfb53ccb862a80e818c3a19bdd386e61e
===
    +    /* Send only once with first queue pair */
    +    if (dev->vq_index != 0) {
    +        return 0;
    +    }
===

Thank you.
---
  - Prasad


