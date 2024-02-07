Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8E8C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 07:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXcVF-0006j1-VF; Wed, 07 Feb 2024 02:37:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rXcVE-0006ir-U0
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 02:37:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rXcV9-00072d-HF
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 02:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707291466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ok3EJpVPnm+pT+p11+wWibWFEL5GlzkBygC3L9VcAo=;
 b=V9SYPumjuYZ1DmCN1W2r638eKptMNVEPYt+/OAR9DaMLpO/TE46XdJpMOsbHKtmz8xgSjx
 OJ8rTjzO+gMyyfGF0zOpGi8sqPZxxMd1kcya2RtLhYlY2wYx7wmDQ9VmIQzbC9+TcKZHFL
 4aZMgcAG45hMnb863DeObGQs7QF+nZ4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-drSoRE3LPqWyXZHXAOhgpw-1; Wed,
 07 Feb 2024 02:37:43 -0500
X-MC-Unique: drSoRE3LPqWyXZHXAOhgpw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AAC561C0651B;
 Wed,  7 Feb 2024 07:37:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 50E681C05E0F;
 Wed,  7 Feb 2024 07:37:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6023E21E66D0; Wed,  7 Feb 2024 08:37:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  qemu-devel@nongnu.org,  Hanna Czenczek
 <hreitz@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Richard
 Henderson <richard.henderson@linaro.org>,  Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH] docs/style: allow C99 mixed declarations
In-Reply-To: <683557e9-fa84-4384-961f-7c29daafe860@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 7 Feb 2024 06:28:01
 +0100")
References: <20240205171819.474283-1-stefanha@redhat.com>
 <ZcEdrp-y5YFsfir4@redhat.com> <87r0hqyw8k.fsf@pond.sub.org>
 <683557e9-fa84-4384-961f-7c29daafe860@linaro.org>
Date: Wed, 07 Feb 2024 08:37:41 +0100
Message-ID: <87msscn2re.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 6/2/24 06:53, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>>> On Mon, Feb 05, 2024 at 12:18:19PM -0500, Stefan Hajnoczi wrote:
>>>> C99 mixed declarations support interleaving of local variable
>>>> declarations and code.
>>>>
>>>> The coding style "generally" forbids C99 mixed declarations with some
>>>> exceptions to the rule. This rule is not checked by checkpatch.pl and
>>>> naturally there are violations in the source tree.
>>>>
>>>> While contemplating adding another exception, I came to the conclusion
>>>> that the best location for declarations depends on context. Let the
>>>> programmer declare variables where it is best for legibility. Don't try
>>>> to define all possible scenarios/exceptions.
> ...
>
>>> Even if the compiler does reliably warn, I think the code pattern
>>> remains misleading to contributors, as the flow control flaw is
>>> very non-obvious.
>>=20
>> Yup.  Strong dislike.
>>=20
>>> Rather than accept the status quo and remove the coding guideline,
>>> I think we should strengthen the guidelines, such that it is
>>> explicitly forbidden in any method that uses 'goto'. Personally
>>> I'd go all the way to -Werror=3Ddeclaration-after-statement, as
>>=20
>> I support this.
>>=20
>>> while C99 mixed decl is appealing,
>>=20
>> Not to me.
>>=20
>> I much prefer declarations and statements to be visually distinct.
>> Putting declarations first and separating from statements them with a
>> blank line accomplishes that.  Less necessary in languages where
>> declarations are syntactically obvious.
>
> But we already implicitly suggest C99, see commit ae7c80a7bd
> ("error: New macro ERRP_GUARD()"):
>
>   * To use ERRP_GUARD(), add it right at the beginning of the function.
>   * @errp can then be used without worrying about the argument being
>   * NULL or &error_fatal.
>
>   #define ERRP_GUARD()                                           \
>      g_auto(ErrorPropagator) _auto_errp_prop =3D {.errp =3D errp};   \
>      do {                                                        \
>          if (!errp || errp =3D=3D &error_fatal) {                    \
>              errp =3D &_auto_errp_prop.local_err;                  \
>          }                                                       \
>      } while (0)

We can make ERRP_GUARD() expand into just a declaration:

    #define ERRP_GUARD()                                            \
        g_auto(ErrorPropagator) _auto_errp_prop =3D {                 \
            .errp =3D errp,                                           \
            .local_err =3D ((!errp || errp =3D=3D &error_fatal            \
                          ? errp =3D &_auto_errp_prop.local_err       \
                          : NULL),                                  \
                          NULL) }

> Or commit 5626f8c6d4 ("rcu: Add automatically released rcu_read_lock
> variants") with WITH_RCU_READ*:
>
> util/aio-posix.c:540:5: error: mixing declarations and code is=20
> incompatible with standards before C99=20
> [-Werror,-Wdeclaration-after-statement]
>      RCU_READ_LOCK_GUARD();
>      ^
> include/qemu/rcu.h:189:28: note: expanded from macro 'RCU_READ_LOCK_GUARD'
>      g_autoptr(RCUReadAuto) _rcu_read_auto __attribute__((unused)) =3D=20
> rcu_read_auto_lock()
>                             ^

Valid example; RCU_READ_LOCK_GUARD() expands into a declaration.

To enable -Wdeclaration-after-statement, we'd have to futz around with
_Pragma.


