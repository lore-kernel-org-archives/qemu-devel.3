Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1300FCF45AA
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 16:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfL4P-0006qO-U9; Mon, 12 Jan 2026 11:47:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vfL39-0006Bp-MV
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 11:45:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vfL37-000414-SC
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 11:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768236348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eFgnxtuwiUCJCq45Nyt40LyTXTT2VzqTAcD+1SSIzOU=;
 b=XOsgu2AmNJKzfx/etDQQxyvadSpTT40PjWdwZSuN8SdAmarNuMSFuR1gD1zNfBcF7Ozk3m
 TIVd3CGSKl7QqCMrdCT+xW17wEFEXTXJMsemmYaO03JSPrCCLAZQ6mU95LLqP5YH/F0oBN
 Ud1soDPxuS2WHOy2F0x+NOzIfJODvM8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-pyMtHz43P9GwUOS7Hw_-0w-1; Mon,
 12 Jan 2026 11:45:47 -0500
X-MC-Unique: pyMtHz43P9GwUOS7Hw_-0w-1
X-Mimecast-MFC-AGG-ID: pyMtHz43P9GwUOS7Hw_-0w_1768236346
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C8461955F34; Mon, 12 Jan 2026 16:45:46 +0000 (UTC)
Received: from localhost (unknown [10.45.225.145])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3879D30001A2; Mon, 12 Jan 2026 16:45:44 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, Thomas Huth
 <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-s390x@nongnu.org, Shameer Kolothum
 <skolothumtho@nvidia.com>
Subject: Re: [PATCH] update-linux-headers: Remove "asm-s390/unistd_32.h"
In-Reply-To: <c44881ae-76f5-469d-a62d-c7de8cac5ed2@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260112155341.1209988-1-clg@redhat.com>
 <3b167280-ce21-42ce-8b7d-18c60ff39509@redhat.com>
 <c44881ae-76f5-469d-a62d-c7de8cac5ed2@redhat.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Mon, 12 Jan 2026 17:45:41 +0100
Message-ID: <87ikd6aife.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jan 12 2026, C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> On 1/12/26 17:07, Thomas Huth wrote:
>> On 12/01/2026 16.53, C=C3=A9dric Le Goater wrote:
>>> The "asm/unistd_32.h" file was generated for the 31-bit compatibility
>>> mode on the s390 architecture and support was removed in v6.19-rc1,
>>> commit 4ac286c4a8d9 ("s390/syscalls: Switch to generic system call
>>> table generation")
>>>
>>> unistd_32.h is no longer generated when running make header_install.
>>> Remove it.
>>>
>>> Reported-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> Cc: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
>>> ---
>>> =C2=A0 scripts/update-linux-headers.sh | 1 -
>>> =C2=A0 1 file changed, 1 deletion(-)
>>>
>>> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-hea=
ders.sh
>>> index 844d9cb9f5e430dcb4833e6225b57173f4befb8c..d09d8cf4c6f0f6a109e899f=
5c8671f64373d9c6a 100755
>>> --- a/scripts/update-linux-headers.sh
>>> +++ b/scripts/update-linux-headers.sh
>>> @@ -154,7 +154,6 @@ EOF
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mkdir -p "$output/include/standard-heade=
rs/asm-$arch"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ $arch =3D s390 ]; then
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cp_portable "$hd=
rdir/include/asm/virtio-ccw.h" "$output/include/standard-headers/asm-s390/"
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cp "$hdrdir/include/asm/uni=
std_32.h" "$output/linux-headers/asm-s390/"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cp "$hdrdir/incl=
ude/asm/unistd_64.h" "$output/linux-headers/asm-s390/"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>=20
>> I think it would make sense to remove linux-headers/asm-s390/unistd_32.h=
 in this patch, too, otherwise this will stay around as a stale file, I gue=
ss?
>
> AFAICT, it will be removed at the first update of linux-headers. See :
>
>    https://lore.kernel.org/qemu-devel/20251222135357.143339-2-skolothumth=
o@nvidia.com/

Yes, the script purges the old files before installing the new versions.

>
>> Anyway,
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Thanks,
>
> C.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


