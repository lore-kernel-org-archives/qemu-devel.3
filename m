Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CA2606A8BE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 11:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hUDOW2nM;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BXqaYolV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRpkK-0002SG-Sr; Fri, 13 Nov 2026 06:47:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRpkJ-0002J1-Id
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 06:47:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRpkH-0001St-MD
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 06:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794570424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x++BKVgcgJN2xEOrOl9yW3T0FbqWdxcztRd9cpPgFW0=;
 b=hUDOW2nMywEOcMxgpzzP8n9V1l0Hd9UyGwi2R9V0NBvQ7oXJy8J1sIsOWFiSrvdH8RpE8p
 0iHBtQbXjniS6Abtg4wstsURqIhWSicqu4Jw17CO5zuWSearEdWGbCPIWDqdVwZCnvMSOb
 3m9fmtZIeat6vk8mLSGtZmk3WZVZA2Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-NAO9l0_5NEOkk8J5Nyr3vQ-1; Fri, 13 Nov 2026 06:47:03 -0500
X-MC-Unique: NAO9l0_5NEOkk8J5Nyr3vQ-1
X-Mimecast-MFC-AGG-ID: NAO9l0_5NEOkk8J5Nyr3vQ_1794570422
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-490a0e72578so533189f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 03:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794570422; x=1795175222; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=x++BKVgcgJN2xEOrOl9yW3T0FbqWdxcztRd9cpPgFW0=;
 b=BXqaYolVsjQ18CWJvzgzETcdhaJ/tDJx4xHLqzTu909aDReoA2yPc2MPIEp3g+JCuV
 SMMsL3FYJpd2xbBY9Rnpp6FejJ0jttcQjphl/qCuzLnHE2vf1dZQPvVtCcFacfEZoXVO
 MzAvT6tL8Uqa+S16SrmPk7HtogcvLKWkvc+BsZTM2kVAFXa1BgEAcN+TCzsEDHWtBgHb
 99gSoUcLrTIjyBGKrCPdPIPyiNAFMmhydoZbR1BZL6iPjHLqOhHPyJxCnXkS+iS5KfsM
 IksWRdJsNIC1jwtlVmHK55MNlxna9a6JFG2qkaWRnwdAxXxJ+ybgeEf80cJC2Np8qrGQ
 J3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794570422; x=1795175222;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x++BKVgcgJN2xEOrOl9yW3T0FbqWdxcztRd9cpPgFW0=;
 b=QLewKmiZJjhYKE1TSeM99c3UrhIKhm/Q/g00qWk/z/RHZqFO+cViF6YFcLiT/cP2qt
 F4fqzAiVIFrh4Biryi1eDMlPhbrarwvZctqdqplBcJKO+Pw0FlJwmoWpoXuSC/lgv9mu
 8bUelrlm+R0t8Rg5Vg3zlgDNNIgDR4eteKOQ11XRt4qNUwpAgS0moiTwuQV4jjTCGdbL
 ViOkmpobZ2vtU9wEmtfsapvcZbPdyqqReohCYSkc1qNi4mEfhu6HbfKEpXZ4FjHsMvPS
 jeW+c0mNlCch+Sg/O9qi5C5PENxVEBOQL87r5rJUEQ8UD5r8104gPmO9GiwNsy41tQxj
 PL5Q==
X-Gm-Message-State: APuU4Z8rh/eOvd2IqCKULHwjldLisn+PyMrp88fXYa/nyXLevvmVMdtr
 1zU/iWS0pfEXmAgWUB0MIXKNo8BboS1+FJ+x2TsUMUBcrVdSHKqc7ynJt2MunbYUqXvqSl2QKlo
 nv3TjT9UQVe6dOiGqcgBtA6kiTtQQOjObUCF6peFHXzNeT27oU/MuPhG4
X-Gm-Gg: AYBFou3c875kFqE2zhW9jbxDsh1uwPOkjZsUs1JgmG+jxDGvTZhCMJZWcLlnW48sFOq
 t8vd2Z+0COs8Ai97tn00TEBLueBg0NWH1wZRLVKtBFUVOcYprSEX8Dm/I3RJaZkBICrCE3RU7l+
 0SkVCXXAoXan2WyW2IvG30FjsJuoqtsDV0BfSvgqPD3vwKPG10vuO1/jj4ubQLV1KsCTCcUlo3B
 CQHXAmhOP1DIUah4xmW0K27csh3OUNKeaZPiGgxMjI7DR8XXMaaxXpcquiyPFAoFqa5amJZ2WLD
 HkClll/XBbG5W9y+bWT5SrQJa4X/PV3sMgVmmYKFQ1wIC7Qq++iDSxhQZc7AYZIwgWzLnzYBO4h
 GOPRhG3krE0drulUV9qKq
X-Received: by 2002:a05:6000:26c1:b0:498:bc2a:8f31 with SMTP id
 ffacd0b85a97d-49c73259d37mr6072823f8f.19.1794570422016; 
 Fri, 13 Nov 2026 03:47:02 -0800 (PST)
X-Received: by 2002:a05:6000:26c1:b0:498:bc2a:8f31 with SMTP id
 ffacd0b85a97d-49c73259d37mr6072767f8f.19.1794570421615; 
 Fri, 13 Nov 2026 03:47:01 -0800 (PST)
Received: from localhost ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c604ecda5sm4696434f8f.37.2026.11.13.03.47.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 03:47:00 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Nov 2026 12:46:59 +0100
Message-Id: <DMU24DRY7JM0.1VG242UKW6HJO@redhat.com>
From: "Tommaso Califano" <tcalifano@redhat.com>
To: <marcandre.lureau@redhat.com>, "Tommaso Califano" <tcalifano@redhat.com>
Cc: <qemu-devel@nongnu.org>, "Markus Armbruster" <armbru@redhat.com>,
 "Richard Henderson" <richard.henderson@linaro.org>, "Junjie Cao"
 <junjie.cao@linux.dev>, <qemu-stable@nongnu.org>
Subject: Re: [PATCH 2/9] hw/usb/dev-mtp: Reset pending write state on
 cancel, reset and error
X-Mailer: aerc 0.22.0
References: <20261112174907.158825-1-tcalifano@redhat.com>
 <20261112174907.158825-3-tcalifano@redhat.com>
 <179455878071.754321.2481506478534104185.b4-review@b4>
In-Reply-To: <179455878071.754321.2481506478534104185.b4-review@b4>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Nov 13, 2026 at 9:33 AM CET, marcandre.lureau wrote:
>> The pending state (s->dataset.filename, s->data_out, s->write_pending)
>> was only partially released when a transaction was canceled, the session
>> closed, the device reset, or the write failed. This left dangling
>> pointers and leaked memory.
>>=20
>> Free and clear these fields consistently on all those paths, and route
>> the early error in usb_mtp_write_data() through the common cleanup.
>>=20
>> Cc: qemu-stable@nongnu.org
>> Fixes: 53735bef108c ("usb-mtp: Advertise SendObjectInfo for write suppor=
t")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4529
>> Suggested-by: Hui Peng <https://gitlab.com/benquike>
>> Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
>> Message-ID: <20261112174907.158825-3-tcalifano@redhat.com>
>> ---
>>  hw/usb/dev-mtp.c | 22 +++++++++++++++-------
>>  1 file changed, 15 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
>> index bc5a6f089178..1c14770a9c05 100644
>> --- a/hw/usb/dev-mtp.c
>> +++ b/hw/usb/dev-mtp.c
>> @@ -1236,6 +1236,13 @@ static void usb_mtp_object_delete(MTPState *s, ui=
nt32_t handle,
>>      }
>>  }
>> =20
>> +static void usb_mtp_reset_pending_write(MTPState *s) {
>
> QEMU C style puts the opening brace of a function definition on its own l=
ine.
>

Yes, sorry I miss that.

>> +    g_free(s->dataset.filename);
>> +    s->dataset.filename =3D NULL;
>> +    s->write_pending =3D false;
>> +    s->dataset.size =3D 0;
>
> Consider also clearing dataset.format and dataset.parent_handle here.

I'll check it.

Thanks,
Tommaso


