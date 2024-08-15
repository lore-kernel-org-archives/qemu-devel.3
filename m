Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95202C52D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 20:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seh5t-0002oQ-TJ; Thu, 15 Aug 2024 16:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1seh5q-0002nH-Qu
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 16:29:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1seh5n-0002dq-Jd
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 16:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723753745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H58M62sK95IIdGGFozBfkq63orPSL40MH8E609F+4Xk=;
 b=HKBMY0pFtexbOBoVtpBkxNT23fgdNY3lcxwYfapoKpAqfNtMsr1zi2qJP2PWVWLF80TQH4
 +5XZs8nAR2oUV7V/FAUDB10vh7ufmSO9MgXnnhLLCVKa4oD/pjs42huHJqH1tq5xYTNI7p
 xt8e93jdJmygOyCsF3lLnjmIc8FlTBA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-9RlSV29VNzG2yOFSyDOqpg-1; Thu, 15 Aug 2024 16:29:03 -0400
X-MC-Unique: 9RlSV29VNzG2yOFSyDOqpg-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6b11d46ebf8so630677b3.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 13:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753743; x=1724358543;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H58M62sK95IIdGGFozBfkq63orPSL40MH8E609F+4Xk=;
 b=F3ZDzviSf+xkpeDD3SS2YTDcG6ZxK4RHkNVqre//SYOah3/DLvFftiKE0cfWUE5tSQ
 rdO/Cgx/+p4KnWU7eRC55XvNHuuWLNQwFQJkg8+J3z8GX5lXiltCeejJNNzqdelFPzF4
 abjGec18ufHX+UyWQvkrYz25NEFVuljbT/HEoks9YERj72Wz4KCjdwu0O8tfjd8unPnr
 sR4xv9rE+qG10zOkVkZB+WB4yJpLIYE5nsUY9USe/92Qg+MHf2b1vsV85ROH93Iiwg4B
 VjWIe/X9XvqH2ntoNktZKTwDEmtVo7s9zrDFqASpZc7TTxwI90I8YjxmYval4BbPoD11
 X9LQ==
X-Gm-Message-State: AOJu0Yx8Fli1Za4iiGkFWSHQdTnxZqBZtJlHypBRjpqfMjeP4toq0skO
 C+7ifFyYSD3s8wfAI5QanOVLkXlJmodwuMzLpRzITCHrjjHp6bU/RUQNjnKA7jMepkiMX3fgYd5
 WmJReN+VXguQE+1UFTOtxBvU1x3Z7rQLXcUSyQv1xTrzZoXAmJB1l
X-Received: by 2002:a05:6902:1445:b0:e0b:d305:9cc2 with SMTP id
 3f1490d57ef6-e1181016d64mr483505276.8.1723753743186; 
 Thu, 15 Aug 2024 13:29:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETuPIPd2GU1Yls3NUuZTfG57d+VHggPC43SZ0HC8Y2IYpMxvfDZh7InhGRgFTVFBd9qiMApA==
X-Received: by 2002:a05:6902:1445:b0:e0b:d305:9cc2 with SMTP id
 3f1490d57ef6-e1181016d64mr483498276.8.1723753742798; 
 Thu, 15 Aug 2024 13:29:02 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6fec6029sm9620276d6.91.2024.08.15.13.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:29:02 -0700 (PDT)
Date: Thu, 15 Aug 2024 16:28:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC V1 0/6] Live update: cpr-transfer
Message-ID: <Zr5lC9ryCsn9FjE2@x1n>
References: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
 <Zpk2bfjS1Wu2QbcO@x1n>
 <90a01b2b-6a72-475f-9232-3af73d1618cf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <90a01b2b-6a72-475f-9232-3af73d1618cf@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
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

On Sat, Jul 20, 2024 at 04:07:50PM -0400, Steven Sistare wrote:
> > > The new user-visible interfaces are:
> > >    * cpr-transfer (MigMode migration parameter)
> > >    * cpr-uri (migration parameter)
> > 
> > I wonder whether this parameter can be avoided already, maybe we can let
> > cpr-transfer depend on unix socket in -incoming, then integrate fd sharing
> > in the same channel?
> 
> You saw the answer in another thread, but I repeat it here for others benefit:
> 
>   "CPR state cannot be sent over the normal migration channel, because devices
>    and backends are created prior to reading the channel, so this mode sends
>    CPR state over a second migration channel that is not visible to the user.
>    New QEMU reads the second channel prior to creating devices or backends."

Today when looking again, I wonder about the other way round: can we make
the new parameter called "-incoming-cpr", working exactly the same as
"cpr-uri" qemu cmdline, but then after cpr is loaded it'll be automatically
be reused for migration incoming ports?

After all, cpr needs to happen already with unix sockets.  Having separate
cmdline options grants user to make the other one to be non-unix, but that
doesn't seem to buy us anything.. then it seems easier to always reuse it,
and restrict cpr-transfer to only work with unix sockets for incoming too?

-- 
Peter Xu


