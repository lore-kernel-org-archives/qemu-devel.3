Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D41C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 20:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEb8I-0005ep-Th; Tue, 04 Jun 2024 16:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sEb8H-0005ef-Ou
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 16:51:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sEb8G-0003Zr-3I
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 16:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717534306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k7kV95jyYlhdBclYTLi8ioBWUFXy6RGodJymG5aVEYY=;
 b=T90vxo/QO2UYJ+yN66ICtH7HRQ84XA+VA5woByHTDR+1D7ZPZrC3DEBK61aT5sEZr3ovTl
 GUTacxuRjGfPtkNABIAPDL3LHOmk+qy1leHSortBCzZtwnHHR3w0WXUSpgpP643ZM0t5jo
 ZQfkxbhRcVdcsttRhabX81bx8noxwWA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-qUfYr2CWNlC2g8fgi_Y9HQ-1; Tue, 04 Jun 2024 16:51:42 -0400
X-MC-Unique: qUfYr2CWNlC2g8fgi_Y9HQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6ae9c4943ddso8960316d6.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 13:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717534302; x=1718139102;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k7kV95jyYlhdBclYTLi8ioBWUFXy6RGodJymG5aVEYY=;
 b=fu1j8UR3qFxEhCqS/kLT7+POyoF5a3Xohssr/ZFXfMSpxvXBGNx7fUqp0otsFX7KGS
 De3j6RTfCeIIPIZWAXMLTfWRz5/n88gl3/7M6rVOyYEiP4U611KmK68k52u+h3Kk16EB
 3UHrA5yNao+JhFH1l7gZY25Q1ruj2AtIAwqu2VyZWNQxcqqn+SEpSNN9uTIYnXRuQz9S
 jJPmwLKwQdP5Qs7XriU275B7aHnnZMUHN+OOJOpxrJMKWgUCVy4CjPYGI1k8vfzSp5wE
 3oGgGDMmcYaRied4oCHfGvHpLYfYP3XYNmji1yLAdTKtVvJO34Hx+rpbJTw1gwjJHWlY
 oxtg==
X-Gm-Message-State: AOJu0YxF/nnerd4TgHicHc7tXZLqESqbVzvdajUlT313miWrW/fzlX3p
 S+QKRaEOgNriimflWBGXVYUZ+M3ObD1GLdBJo8BobCLMhPJfozp/okie9LcSjeXoCFpDrgqGQui
 I+in5qwkPYdN30km6XqMzxX8vWqNDOUaC29BtXYAxIxglSVIw4JH+
X-Received: by 2002:a05:6214:240f:b0:6ae:4e11:837c with SMTP id
 6a1803df08f44-6b020315a04mr5577666d6.1.1717534301850; 
 Tue, 04 Jun 2024 13:51:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe5b7ewk1PbCsq3YHEgh1BrK3j6OXdYrnvUoYUxW4QI7Tn/xU3MTpedDu/dkyKy8mzIT07dw==
X-Received: by 2002:a05:6214:240f:b0:6ae:4e11:837c with SMTP id
 6a1803df08f44-6b020315a04mr5577376d6.1.1717534301229; 
 Tue, 04 Jun 2024 13:51:41 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ae4b4070d1sm42287906d6.82.2024.06.04.13.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 13:51:40 -0700 (PDT)
Date: Tue, 4 Jun 2024 16:51:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 15/18] tests/qtest/migration: Add a test for
 mapped-ram with passing of fds
Message-ID: <Zl9-WjPjfOMScf_v@x1n>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-16-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523190548.23977-16-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, May 23, 2024 at 04:05:45PM -0300, Fabiano Rosas wrote:
> Add a multifd test for mapped-ram with passing of fds into QEMU. This
> is how libvirt will consume the feature.
> 
> There are a couple of details to the fdset mechanism:
> 
> - multifd needs two distinct file descriptors (not duplicated with
>   dup()) so it can enable O_DIRECT only on the channels that do
>   aligned IO. The dup() system call creates file descriptors that
>   share status flags, of which O_DIRECT is one.
> 
> - the open() access mode flags used for the fds passed into QEMU need
>   to match the flags QEMU uses to open the file. Currently O_WRONLY
>   for src and O_RDONLY for dst.
> 
> Note that fdset code goes under _WIN32 because fd passing is not
> supported on Windows.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


