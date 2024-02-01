Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A04DC48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 21:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVesj-0001hD-IP; Thu, 01 Feb 2024 16:46:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rVesh-0001gs-IV
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 16:45:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rVesf-0000ZD-JP
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 16:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706823955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3gtNwW5wf39Q0Yl8gf9l66c3jerywRvOOliO50Ef/aE=;
 b=Hx5QNG9fII2yMIQPrLE1PAYuiArqnnLYTJtPfXtG5kOFYn/ypnnv4lj7oWknD7pJY09+9g
 vP7W3PBXSS2llvnDW9Zs7vgPIFjNPrA6PalcSERsmgLePPgpHnpTH0iArJP6Wwe48d8tZ3
 xDOn6TpkNHB4FkhKU/XhFuePuSKZDXI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-3xVUIwChOuqaO_QScrrH0A-1; Thu, 01 Feb 2024 16:45:54 -0500
X-MC-Unique: 3xVUIwChOuqaO_QScrrH0A-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2962ab5ddfbso601315a91.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 13:45:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706823953; x=1707428753;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3gtNwW5wf39Q0Yl8gf9l66c3jerywRvOOliO50Ef/aE=;
 b=UJ38zOaRP3dGjR0dVEFHJPhfVZJx3IVT905EKS+AFSIVn79+kp+qLoimxaizpTpkSQ
 aP0U8VxUqOWqo4WV27WdaGNX6THeB2z4d0m4Vz76CRUB2IR7P8pKCkl5xA5l7cRdgVzr
 zUO1RqynDVrUWiGemafSmto0RZDb2SImz/MrwRIBMnGxqMFZTzzExxnXnReyxcGyktWY
 a19tGoG9j2E2XExKdMQpC4r66E0H/MeSoFZpog6gVPXSDlYch0xkHUrWFP5vGsOugAK6
 1PQRsigCqZ4WVR08uMIo9Ada8R6boCC1aUR+oWhxC+G3fv1BZLi2LuAhHZaS2aLHQuIa
 Nh/w==
X-Gm-Message-State: AOJu0YyecGk0YVn9D+tN9+fbUMhdWFXT+uxYlzMMZfRL9b1BrZdAjz5/
 Dt6a9VQGbZWXWv3LMplovhrqRu5UXtxxXEptju+/+gGT+ocPZCrD6hAPC7eVWkvwQcvnB6LWBZW
 p/wNoHHHQ+u4vPMbb4FILl5zZwIOMkr9pdJWQsToAk/3aIt1fLBgFgJeeMWcps8UqXIA75aNKQA
 tB+YhL2ZQUgKOrk0dgocMhMcV1WTM=
X-Received: by 2002:a17:90a:e2d6:b0:28d:bab1:e94a with SMTP id
 fr22-20020a17090ae2d600b0028dbab1e94amr3796562pjb.32.1706823953034; 
 Thu, 01 Feb 2024 13:45:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+xwOMDyaP/A+jsQwKCLodb9Qd/B5a6Lhg91ghKI0czf4FKIbEsOmJUZqTpjIOEWz3gO5gs5BHkBQIAJc9NOg=
X-Received: by 2002:a17:90a:e2d6:b0:28d:bab1:e94a with SMTP id
 fr22-20020a17090ae2d600b0028dbab1e94amr3796545pjb.32.1706823952660; Thu, 01
 Feb 2024 13:45:52 -0800 (PST)
MIME-Version: 1.0
References: <20240120095327.666239-1-armbru@redhat.com>
 <20240120095327.666239-5-armbru@redhat.com>
In-Reply-To: <20240120095327.666239-5-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 1 Feb 2024 16:45:41 -0500
Message-ID: <CAFn=p-aUAS7cxRsOm7DCtjYFxDgt82F3OnA5Kao-e8ujCvihww@mail.gmail.com>
Subject: Re: [PATCH 4/7] docs/interop/bitmaps: Clean up a reference to
 qemu-qmp-ref
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Jan 20, 2024 at 4:53=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> docs/interop/bitmaps.rst uses references like
>
>     `qemu-qmp-ref <qemu-qmp-ref.html>`_
>     `query-block <qemu-qmp-ref.html#index-query_002dblock>`_
>
> to refer to and into docs/interop/qemu-qmp-ref.rst.
>
> Clean up the former: use :doc:`qemu-qmp-ref`.
>
> I don't know how to clean up the latter.

It used to have anchors that seemed to have semi-stable names, but I
guess that's not really true anymore.

Now it's just stuff like `qapidoc-423`. Well, neat...

No, I think this requires the Real Fix :tm: now...

>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/interop/bitmaps.rst | 4 ++--
>  qapi/introspect.json     | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/docs/interop/bitmaps.rst b/docs/interop/bitmaps.rst
> index c731be2f01..ddf8947d54 100644
> --- a/docs/interop/bitmaps.rst
> +++ b/docs/interop/bitmaps.rst
> @@ -167,8 +167,8 @@ Basic QMP Usage
>
>  The primary interface to manipulating bitmap objects is via the QMP
>  interface. If you are not familiar, see the :doc:`qmp-spec` for the
> -protocol, and `qemu-qmp-ref <qemu-qmp-ref.html>`_ for a full
> -reference of all QMP commands.
> +protocol, and :doc:`qemu-qmp-ref` for a full reference of all QMP
> +commands.
>
>  Supported Commands
>  ~~~~~~~~~~~~~~~~~~
> diff --git a/qapi/introspect.json b/qapi/introspect.json
> index ebc4e199d2..8df1ce85ed 100644
> --- a/qapi/introspect.json
> +++ b/qapi/introspect.json
> @@ -260,8 +260,8 @@
>  # Additional SchemaInfo members for meta-type 'alternate'.
>  #
>  # @members: the alternate type's members, in no particular order.  The
> -#     members' wire encoding is distinct, see :doc:`qapi-code-gen`
> -#     section Alternate types.
> +#     members' wire encoding is distinct, see
> +#     :doc:`/devel/qapi-code-gen` section Alternate types.
>  #
>  # On the wire, this can be any of the members.
>  #
> --
> 2.43.0
>


