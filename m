Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0DF10F931B
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 02:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7l8d-0008Ip-Hg; Tue, 31 Mar 2026 22:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w7l8b-0008IR-Kd
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 22:16:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w7l8a-0003ie-19
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 22:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775009814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lMG+ygO4Lhrn57yq5lgzzZ2C3UUkfREJ8CQxKTt0bO4=;
 b=hqQidmlSF2K44qvdTzwnxMt+dR6jrUWory42T0iglndNjXxgdxHAYYbKZXWUL0BgDyS3dH
 A2KFYHW+0w38WQWUDcO+4Ed1fhAlo/j2SHuDbZc4yotAAnOKcIhfmD2pS7zf03Er3BKhc4
 +fQZ5JiJA3AF3UOrGDel4h7GN+cEKm4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-ouddckIkPdiFphdxknoEtg-1; Tue, 31 Mar 2026 22:16:53 -0400
X-MC-Unique: ouddckIkPdiFphdxknoEtg-1
X-Mimecast-MFC-AGG-ID: ouddckIkPdiFphdxknoEtg_1775009812
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c76acbe2829so3601354a12.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 19:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775009812; x=1775614612; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lMG+ygO4Lhrn57yq5lgzzZ2C3UUkfREJ8CQxKTt0bO4=;
 b=PQ3pX02P5V+FoTYamD+lypCaKqQXcv7ZdQcRPZS9jTyMT/JCwywUSzbyBarhymdQn2
 XIxHQisO+VFZ+aiB8UUTqmjE7VLNwH4sIceMg8H/zczeCVIxkqiyLnW+aYH/PKNvy9Gi
 fYaROG4J3S+u2GyiN1+ifvNvBXBy2SncagXuqqF9r3te2aK5BqjMsNNc0w1Y7MYBkA38
 PD16MFsMs2LH0aNMqWu/vCF+ccoUYEmEXGenq9h3JMnnaAU7loOvaTh+Wr7q+a9lavmg
 CHPmneei/JSNJdRy0ec6ljDjCrB/nr1IrIcGBqepBmOVv/3J2xTgKF46Jfe3sGPjZR7w
 kmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775009812; x=1775614612;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lMG+ygO4Lhrn57yq5lgzzZ2C3UUkfREJ8CQxKTt0bO4=;
 b=A5ooCidf70f1Uq+PDZb6no1Vov+LFb7pKtnFQuK8vYb3SmeD23aLax6kaHbd8yhNOz
 nzE3NP+wpnSc/SUhZnT135jWOdfuckyZbJo+LJsheEefHyVNUGghDicM289MI0U+c5id
 VnvLnHLtwew8Z21XDjC3ABNQ89PhZQ8WmYEB/b4mg7WDzVDvYxQuhIhLNIoSo/rQvGYB
 rHyiuS05DlBfmmyJrxsaFwMdpVb/dVRGUs/WpNcovQ51A/BqQJfY6jb9hJ4bC9CiPRZz
 k3egTM+++Vdd0xmQgJr4txIedyN7cL0EJe90mByUatr7WNVK9rh0EGq+w0e4/bTtTw+o
 4fBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtrgC3ooluH/dq++XknS+VrCF+crEJTWajMHkB89/6pBG+tnNBq1O50S4q8vLpqVYAsSUJZYMdHkns@nongnu.org
X-Gm-Message-State: AOJu0YwA4ynFdePEHl3ZHSmzTy0dKD9jTq4N3Q4GMlvkRpKEIcV6xZkx
 tQAThS9y9RI3g01VFaTzdiY8zGxKgvTSDYkVTVshh9thuFWr1obFbOn2Lb26rCbv0UTafhnYMpa
 TKWu6Rj9eRCf9F5H4hJQWxBATXr1lvWpH4RpJM8jPuFCeQEWcxECIxY0p
X-Gm-Gg: ATEYQzwrgKfSQqW4nZLwhTTc9ZSqSeRR9MLUCQaA6ks+4Ix5KTWxqawbRFI/U3baV++
 L7ZGRzAPb/cpCIvFY5Fy8e8KniFE3CEXGY0XOf/yI5vvIF/oD4Z3TkJmipVOwxk5k5Z10Vt0SFy
 Lf+ywTioU/vUnvRC3+bzaNZd4HsksoTmX1BB/OSG5bTzUWG0g9leqXjCjdZJ0UgU9L49qe9mQZT
 pt02ciogB+1C/fTvFr3r2XIzS9T7qly0pFvIgryYrjQ/U7+NlNfoRslfknSstI+ht+ssfFPr163
 Wp4TgmQdAGS56eProZS6FXJ0BaN+X6ZAJ3/6dSuITBvwdzu+09TPkAOAR5YbGin0w9F8jhiY5WH
 Ngp1yabc1xtzKiGULA1Ut4SbEQWdT+lpz9uQuq+oK5cIy1yylM0TuElmA73OJ/VdaehWeA5SqRS
 I=
X-Received: by 2002:a05:6a00:1951:b0:82a:720a:4cde with SMTP id
 d2e1a72fcca58-82ce88f5ecbmr1947282b3a.2.1775009811751; 
 Tue, 31 Mar 2026 19:16:51 -0700 (PDT)
X-Received: by 2002:a05:6a00:1951:b0:82a:720a:4cde with SMTP id
 d2e1a72fcca58-82ce88f5ecbmr1947254b3a.2.1775009811318; 
 Tue, 31 Mar 2026 19:16:51 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ceff55405sm174688b3a.11.2026.03.31.19.16.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2026 19:16:50 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 2/3] igvm: fix memory leak on failed memory region init
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <FF77CA5D-E208-4CF7-A4A9-714FFF605C6E@redhat.com>
Date: Wed, 1 Apr 2026 07:46:36 +0530
Cc: Luigi Leonardi <leonardi@redhat.com>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 Oliver Steffen <osteffen@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <659AAB33-FB80-4421-9AD7-67E888CA7571@redhat.com>
References: <20260330-igvm_fixes-v1-0-03587a5a808b@redhat.com>
 <20260330-igvm_fixes-v1-2-03587a5a808b@redhat.com>
 <F98D82E4-5C4B-4A36-A386-1B2FF91034DD@redhat.com>
 <actsWgsnHAuQ2lf9@sirius.home.kraxel.org>
 <FF77CA5D-E208-4CF7-A4A9-714FFF605C6E@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3864.400.21)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 31 Mar 2026, at 12:37=E2=80=AFPM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
>=20
>=20
>> On 31 Mar 2026, at 12:11=E2=80=AFPM, Gerd Hoffmann =
<kraxel@redhat.com> wrote:
>>=20
>> On Tue, Mar 31, 2026 at 11:45:55AM +0530, Ani Sinha wrote:
>>>=20
>>>=20
>>>> On 30 Mar 2026, at 6:13=E2=80=AFPM, Luigi Leonardi =
<leonardi@redhat.com> wrote:
>>>>=20
>>>> When memory_region_init_* fail, `igvm_pages` is not freed causing a =
leak.
>>>>=20
>>>> Free `igvm_pages` in the error path.
>>>>=20
>>>> Fixes: c1d466d267cf ("backends/igvm: Add IGVM loader and =
configuration")
>>>> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>=20
> Reviewed-by: Ani Sinha <anisinha@redhat.com>

Btw, I think this is 11.0 material, particularly since =
https://gitlab.com/qemu-project/qemu/-/commit/a85c5ed33fc203d5ab6f863cec00=
f6257251be76
got merged.


>=20
>>>> ---
>>>> backends/igvm.c | 2 ++
>>>> 1 file changed, 2 insertions(+)
>>>>=20
>>>> diff --git a/backends/igvm.c b/backends/igvm.c
>>>> index =
50f0d6fb9a7bacddce91f095b6e2710ecbc79c6f..c347d0c17e7ee744e450d42e677946ab=
ad8a7211 100644
>>>> --- a/backends/igvm.c
>>>> +++ b/backends/igvm.c
>>>> @@ -216,11 +216,13 @@ static void *qigvm_prepare_memory(QIgvm *ctx, =
uint64_t addr, uint64_t size,
>>>>           ctx->machine_state->cgs->require_guest_memfd) {
>>>>           if (!memory_region_init_ram_guest_memfd(igvm_pages, NULL,
>>>>                                                   region_name, =
size, errp)) {
>>>> +                g_free(igvm_pages);
>>>=20
>>> Why not use g_autofree? That way you do not need to explicitly free =
it.
>>=20
>> autofree does not work because it must be freed in the error case =
only.
>>=20
>> take care,
>> Gerd



