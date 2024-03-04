Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21454C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 20:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhFG9-0007kk-QW; Mon, 04 Mar 2024 15:50:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhFG7-0007kW-9D
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 15:50:03 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhFG5-0002XT-BD
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 15:50:03 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B6BDE2067A;
 Mon,  4 Mar 2024 20:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709585399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Q/kW6e7YwGE4mHLfpqjo9vEd3SZzOTFgOEdApgd6Ek=;
 b=AkwNqgcP3JIvWZfMP6DXbJdbbTyRmgUJC+0eoHVziEwqj+CKfQi+fUf/hWxubdgKKmJ66h
 YR3M9tB+2LatmuwBgVOEjGuCRrOcsbtXBtLFAcSbuG4gj9KK02H15cwEdSmDg28mTsAfTY
 FUBkgl7eTAWEhcQSeyb1DG7+cLUwi7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709585399;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Q/kW6e7YwGE4mHLfpqjo9vEd3SZzOTFgOEdApgd6Ek=;
 b=/yZYPBDHaL6PFz1zVs2FtL1sL4HyKdPtwcL/9MiCHGDMoPajZeW8hvdSswvcHaFw8mCXQz
 GfoMr+mXZ39tMXAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709585399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Q/kW6e7YwGE4mHLfpqjo9vEd3SZzOTFgOEdApgd6Ek=;
 b=AkwNqgcP3JIvWZfMP6DXbJdbbTyRmgUJC+0eoHVziEwqj+CKfQi+fUf/hWxubdgKKmJ66h
 YR3M9tB+2LatmuwBgVOEjGuCRrOcsbtXBtLFAcSbuG4gj9KK02H15cwEdSmDg28mTsAfTY
 FUBkgl7eTAWEhcQSeyb1DG7+cLUwi7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709585399;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Q/kW6e7YwGE4mHLfpqjo9vEd3SZzOTFgOEdApgd6Ek=;
 b=/yZYPBDHaL6PFz1zVs2FtL1sL4HyKdPtwcL/9MiCHGDMoPajZeW8hvdSswvcHaFw8mCXQz
 GfoMr+mXZ39tMXAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F06813A5B;
 Mon,  4 Mar 2024 20:49:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 92MFAvcz5mWARAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 04 Mar 2024 20:49:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, Avihai Horon <avihaih@nvidia.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Markus Armbruster
 <armbru@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, Halil Pasic
 <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PATCH v3 01/26] s390/stattrib: Add Error** argument to
 set_migrationmode() handler
In-Reply-To: <20240304122844.1888308-2-clg@redhat.com>
References: <20240304122844.1888308-1-clg@redhat.com>
 <20240304122844.1888308-2-clg@redhat.com>
Date: Mon, 04 Mar 2024 17:49:56 -0300
Message-ID: <87v861hgcr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[11]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

C=C3=A9dric Le Goater <clg@redhat.com> writes:

> This will prepare ground for futur changes adding an Error** argument
> to the save_setup() handler. We need to make sure that on failure,
> set_migrationmode() always sets a new error. See the Rules section in
> qapi/error.h.
>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  include/hw/s390x/storage-attributes.h |  2 +-
>  hw/s390x/s390-stattrib-kvm.c          | 12 ++++++++++--
>  hw/s390x/s390-stattrib.c              | 14 +++++++++-----
>  3 files changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/include/hw/s390x/storage-attributes.h b/include/hw/s390x/sto=
rage-attributes.h
> index 5239eb538c1b087797867a247abfc14551af6a4d..8921a04d514bf64a3113255ee=
10ed33fc598ae06 100644
> --- a/include/hw/s390x/storage-attributes.h
> +++ b/include/hw/s390x/storage-attributes.h
> @@ -39,7 +39,7 @@ struct S390StAttribClass {
>      int (*set_stattr)(S390StAttribState *sa, uint64_t start_gfn,
>                        uint32_t count, uint8_t *values);
>      void (*synchronize)(S390StAttribState *sa);
> -    int (*set_migrationmode)(S390StAttribState *sa, bool value);
> +    int (*set_migrationmode)(S390StAttribState *sa, bool value, Error **=
errp);
>      int (*get_active)(S390StAttribState *sa);
>      long long (*get_dirtycount)(S390StAttribState *sa);
>  };
> diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
> index 24cd01382e2d74d62c2d7e980eb6aca1077d893d..357cea2c987213b867c81b0e2=
58f7d0c293fe665 100644
> --- a/hw/s390x/s390-stattrib-kvm.c
> +++ b/hw/s390x/s390-stattrib-kvm.c
> @@ -17,6 +17,7 @@
>  #include "sysemu/kvm.h"
>  #include "exec/ram_addr.h"
>  #include "kvm/kvm_s390x.h"
> +#include "qapi/error.h"
>=20=20
>  Object *kvm_s390_stattrib_create(void)
>  {
> @@ -137,14 +138,21 @@ static void kvm_s390_stattrib_synchronize(S390StAtt=
ribState *sa)
>      }
>  }
>=20=20
> -static int kvm_s390_stattrib_set_migrationmode(S390StAttribState *sa, bo=
ol val)
> +static int kvm_s390_stattrib_set_migrationmode(S390StAttribState *sa, bo=
ol val,
> +                                               Error **errp)
>  {
>      struct kvm_device_attr attr =3D {
>          .group =3D KVM_S390_VM_MIGRATION,
>          .attr =3D val,
>          .addr =3D 0,
>      };
> -    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
> +    int r;
> +
> +    r =3D kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
> +    if (r) {
> +        error_setg_errno(errp, -r, "KVM_S390_SET_CMMA_BITS failed");

Did you mean KVM_SET_DEVICE_ATTR?

> +    }
> +    return r;
>  }
>=20=20
>  static long long kvm_s390_stattrib_get_dirtycount(S390StAttribState *sa)
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index c483b62a9b5f71772639fc180bdad15ecb6711cb..e99de190332a82363b1388bbc=
450013149295bc0 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -60,11 +60,12 @@ void hmp_migrationmode(Monitor *mon, const QDict *qdi=
ct)
>      S390StAttribState *sas =3D s390_get_stattrib_device();
>      S390StAttribClass *sac =3D S390_STATTRIB_GET_CLASS(sas);
>      uint64_t what =3D qdict_get_int(qdict, "mode");
> +    Error *local_err =3D NULL;
>      int r;
>=20=20
> -    r =3D sac->set_migrationmode(sas, what);
> +    r =3D sac->set_migrationmode(sas, what, &local_err);
>      if (r < 0) {
> -        monitor_printf(mon, "Error: %s", strerror(-r));
> +        monitor_printf(mon, "Error: %s", error_get_pretty(local_err));
>      }
>  }
>=20=20
> @@ -170,13 +171,15 @@ static int cmma_save_setup(QEMUFile *f, void *opaqu=
e)
>  {
>      S390StAttribState *sas =3D S390_STATTRIB(opaque);
>      S390StAttribClass *sac =3D S390_STATTRIB_GET_CLASS(sas);
> +    Error *local_err =3D NULL;
>      int res;
>      /*
>       * Signal that we want to start a migration, thus needing PGSTE dirty
>       * tracking.
>       */
> -    res =3D sac->set_migrationmode(sas, 1);
> +    res =3D sac->set_migrationmode(sas, true, &local_err);
>      if (res) {
> +        error_report_err(local_err);
>          return res;
>      }
>      qemu_put_be64(f, STATTR_FLAG_EOS);
> @@ -260,7 +263,7 @@ static void cmma_save_cleanup(void *opaque)
>  {
>      S390StAttribState *sas =3D S390_STATTRIB(opaque);
>      S390StAttribClass *sac =3D S390_STATTRIB_GET_CLASS(sas);
> -    sac->set_migrationmode(sas, 0);
> +    sac->set_migrationmode(sas, false, NULL);
>  }
>=20=20
>  static bool cmma_active(void *opaque)
> @@ -293,7 +296,8 @@ static long long qemu_s390_get_dirtycount_stub(S390St=
AttribState *sa)
>  {
>      return 0;
>  }
> -static int qemu_s390_set_migrationmode_stub(S390StAttribState *sa, bool =
value)
> +static int qemu_s390_set_migrationmode_stub(S390StAttribState *sa, bool =
value,
> +                                            Error **errp)
>  {
>      return 0;
>  }

