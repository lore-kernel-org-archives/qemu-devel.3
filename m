Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AFCC5320E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 11:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg0r9-0008Nj-V6; Mon, 19 Aug 2024 07:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1sg0r7-0008N1-FH
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 07:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1sg0r4-0001nH-M7
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 07:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724068040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H+WJVLoXjk8eTEWpbY79SJ7MnaZFVEUaFEFGdKsTupA=;
 b=B9aHXiTXGG901q35e0jU9rfnDVWZJxVcnJoKyGeO5/8TBP3PAgJdkwqmMSFHs9W8scwteH
 kwA3MuxpzefDKuZkGRUpRvhsZZkJ8SYLp4/1zNF5vCDb07rAYWoadEqBBYYvYlYE/aqAw9
 WVgmcj+13CcRHbuNMpZxJ6YB1WEWEDY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-Crq6x2erNtmi2y4HLbUfBA-1; Mon, 19 Aug 2024 07:47:17 -0400
X-MC-Unique: Crq6x2erNtmi2y4HLbUfBA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a7ab81eea72so335969766b.2
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 04:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724068036; x=1724672836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H+WJVLoXjk8eTEWpbY79SJ7MnaZFVEUaFEFGdKsTupA=;
 b=BPLimlWyoEGZCMBNA8f4cYHSEvagfM7ETL36ZFAkXe6XwSdvmrYg+q0g1fDuw5R95U
 EvlOTCvJxmAqOeyelxVS2ru2pVS64JLeZEMbVthBzdU9QTU6Z/OUD1UWY7Y1bQx5TCQd
 QyM1RFEM5Q7deF3yO5N/3JLL+nCgXZ9xHQa6+yJwmiadlForoDZF9KN2PcDe5TpqUvMg
 TQHjrd+eVnoVOACFa+uhAqHKeA8Hrh7LDpnPTHQYSATeJlwATy+voKcjKsP5znzI05ag
 SHen4KJZWjcX/lwvzLjaAQ6FUiQKTz0ULd6PRd306mlKiRA9i5zrU9UxT1uM3FRoih1C
 yHmg==
X-Gm-Message-State: AOJu0YyLpBP/2srYIw/LcTZZO8MVzkzX5teiTl2qzIdV46gycvgEnJvv
 iztMUWs+4vqEogATMMtzvPtF5E0xn3q2W50v1YtSiZuwVKXag+JkPbJ6h1+ml31mzPAPPT2O4J0
 lfqfwo8F0hkYyKJy734AEhijwKb336Ga/gssQq9S9CWBZl37fS9aipNuRzwWIINC0VRJrl0jWU5
 H8EldZVANmhW8o6pVcaRQVJcBjFZI=
X-Received: by 2002:a17:907:d862:b0:a7a:b781:60ed with SMTP id
 a640c23a62f3a-a839292f71fmr720890666b.17.1724068036161; 
 Mon, 19 Aug 2024 04:47:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8b4mZo2o0S8W6C2ziuhj6XWhvnvCBhcBQJw5XkR6aO0l14ADhzh6mslM4mXrWKPebAL2WS//xbp3ZbfNMXd8=
X-Received: by 2002:a17:907:d862:b0:a7a:b781:60ed with SMTP id
 a640c23a62f3a-a839292f71fmr720888766b.17.1724068035609; Mon, 19 Aug 2024
 04:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240813031115.129000-1-demeng@redhat.com>
 <CAPMcbCpcQ76EeLxDkAwn6jRQjPEbHzz9QMNDNiX54r+kqxo5Vg@mail.gmail.com>
In-Reply-To: <CAPMcbCpcQ76EeLxDkAwn6jRQjPEbHzz9QMNDNiX54r+kqxo5Vg@mail.gmail.com>
From: Dehan Meng <demeng@redhat.com>
Date: Mon, 19 Aug 2024 19:47:03 +0800
Message-ID: <CA+kPPJzRTZSsgyCxF-j-OsHd=p0bbFj6pPsNTZGENgnz23du1A@mail.gmail.com>
Subject: Re: [PATCH] qemu-guest-agent: Update the logfile path of
 qga-fsfreeze-hook.log
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, mrezanin@redhat.com
Content-Type: multipart/alternative; boundary="000000000000d4db21062007debb"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000d4db21062007debb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

'/var/log/qemu-ga' is more reasonable and forward-looking to facilitate
future log management. All qga-related logs would be better placed in a
dedicated and unified log directory.

On Wed, Aug 14, 2024 at 7:54=E2=80=AFPM Konstantin Kostiuk <kkostiuk@redhat=
.com>
wrote:

> This bug looks specific to the RedHat SELinux configuration.
> Is this any reason to move LOGFILE except this?
>
> Best Regards,
> Konstantin Kostiuk.
>
>
> On Tue, Aug 13, 2024 at 6:11=E2=80=AFAM Dehan Meng <demeng@redhat.com> wr=
ote:
>
>> Since '/var/log/qga-fsfreeze-hook.log' is not included to proper
>> selinux context 'system_u:object_r:virt_qemu_ga_log_t:s0', it
>> should be changed to '/var/log/qemu-ga/qga-fsfreeze-hook.log'
>>
>> Jira: https://issues.redhat.com/browse/RHEL-52250
>> Signed-off-by: Dehan Meng <demeng@redhat.com>
>> ---
>>  scripts/qemu-guest-agent/fsfreeze-hook | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/qemu-guest-agent/fsfreeze-hook
>> b/scripts/qemu-guest-agent/fsfreeze-hook
>> index 13aafd4845..98aad5e18b 100755
>> --- a/scripts/qemu-guest-agent/fsfreeze-hook
>> +++ b/scripts/qemu-guest-agent/fsfreeze-hook
>> @@ -7,7 +7,7 @@
>>  # "freeze" argument before the filesystem is frozen. And for
>> fsfreeze-thaw
>>  # request, it is issued with "thaw" argument after filesystem is thawed=
.
>>
>> -LOGFILE=3D/var/log/qga-fsfreeze-hook.log
>> +LOGFILE=3D/var/log/qemu-ga/qga-fsfreeze-hook.log
>>  FSFREEZE_D=3D$(dirname -- "$0")/fsfreeze-hook.d
>>
>>  # Check whether file $1 is a backup or rpm-generated file and should be
>> ignored
>> --
>> 2.40.1
>>
>>

--000000000000d4db21062007debb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&#39;/var/log/qemu-ga&#39; is more reasonable and forward-=
looking to facilitate future log management. All qga-related logs would be =
better placed in a dedicated and unified log directory.</div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 14, 2024=
 at 7:54=E2=80=AFPM Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redha=
t.com">kkostiuk@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex"><div dir=3D"ltr"><div>This bug looks specific to =
the RedHat SELinux configuration.</div><div>Is this any reason to move LOGF=
ILE except this?<br></div><div><br></div><div><div><div dir=3D"ltr" class=
=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards,</div><div>Konstant=
in Kostiuk.</div></div></div></div><br></div></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 13, 2024 at 6:11=
=E2=80=AFAM Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com" target=3D"_=
blank">demeng@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">Since &#39;/var/log/qga-fsfreeze-hook.log&#39; is n=
ot included to proper<br>
selinux context &#39;system_u:object_r:virt_qemu_ga_log_t:s0&#39;, it<br>
should be changed to &#39;/var/log/qemu-ga/qga-fsfreeze-hook.log&#39;<br>
<br>
Jira: <a href=3D"https://issues.redhat.com/browse/RHEL-52250" rel=3D"norefe=
rrer" target=3D"_blank">https://issues.redhat.com/browse/RHEL-52250</a><br>
Signed-off-by: Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com" target=
=3D"_blank">demeng@redhat.com</a>&gt;<br>
---<br>
=C2=A0scripts/qemu-guest-agent/fsfreeze-hook | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/scripts/qemu-guest-agent/fsfreeze-hook b/scripts/qemu-guest-ag=
ent/fsfreeze-hook<br>
index 13aafd4845..98aad5e18b 100755<br>
--- a/scripts/qemu-guest-agent/fsfreeze-hook<br>
+++ b/scripts/qemu-guest-agent/fsfreeze-hook<br>
@@ -7,7 +7,7 @@<br>
=C2=A0# &quot;freeze&quot; argument before the filesystem is frozen. And fo=
r fsfreeze-thaw<br>
=C2=A0# request, it is issued with &quot;thaw&quot; argument after filesyst=
em is thawed.<br>
<br>
-LOGFILE=3D/var/log/qga-fsfreeze-hook.log<br>
+LOGFILE=3D/var/log/qemu-ga/qga-fsfreeze-hook.log<br>
=C2=A0FSFREEZE_D=3D$(dirname -- &quot;$0&quot;)/fsfreeze-hook.d<br>
<br>
=C2=A0# Check whether file $1 is a backup or rpm-generated file and should =
be ignored<br>
-- <br>
2.40.1<br>
<br>
</blockquote></div>
</blockquote></div>

--000000000000d4db21062007debb--


