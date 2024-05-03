Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7DFC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 14:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2tyf-00033F-Ro; Fri, 03 May 2024 10:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2tyd-00032R-Uo
 for qemu-devel@nongnu.org; Fri, 03 May 2024 10:33:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2tyY-0007kH-Hr
 for qemu-devel@nongnu.org; Fri, 03 May 2024 10:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714746805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lrp038+BnCCIcL2uudlEhxcEnD1UXWGK6w8wIqAzDqs=;
 b=c4lh5kbjZwNsG9jFFeFnSGEThKiXJZYxe4LchhIUr7F/wzoDVNlYVULd1avQ6Vcf7lfb3G
 YYKUtEWUnENyLnCallGbnd54kdwpuOrl4O+42ztoCoURsAnwM//EGbfLM9mnkQSZsytaKp
 uKr+E/s6kcQFFBmD5q3pdSwvhXgWW+4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-B-l3FBsmP0C1aow4USJsPg-1; Fri, 03 May 2024 10:33:24 -0400
X-MC-Unique: B-l3FBsmP0C1aow4USJsPg-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-434ed2e412fso27328851cf.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 07:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714746804; x=1715351604;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lrp038+BnCCIcL2uudlEhxcEnD1UXWGK6w8wIqAzDqs=;
 b=pvcTtU7dA9ZNxchs686U2yZO6OAjDNJ/3ENNSYrGRkfN5M6BLb1MVFwovQ8LgVjOAX
 WHxGigEb6FTH/Qn3riSrVyS6OP3zF6JmDcxztUZ14GUkwg8jWYwOcjCW4BVBS4ZraCgy
 VjtLISCw1EQXZ+p7XFPvDCLEQHAdf5Hu4y1eEhucPHOIyf0h2/3AxYOVaVMEaZ9gm69b
 fRBOFLZmpAPdlQkT/KmvNT4oWNflkybPF1PHKbrt66gT+T3eTbcueogQpptpKs8EJx9g
 HVZxruV09DzhOZCo7DtfyH1rHSrlABXDoFBeaqVb8EJ6int6v52JrKzbzzKurwptitGX
 S8Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvBGSzKgGrBgMR2QtCBqH65cZJIiSk1UrQGoHgJEmcIzFntyM/vas+54fvxZPTKqCDhNsG9xm95Xg/yiFSbcSJqbncwWE=
X-Gm-Message-State: AOJu0YyNVDC26LmS1jMMZHHDBdTZd1WudhXNJ+Lkouagh3gMT9fb7puv
 oI3OYHzPpkcQgog48PoM2Kuw9ZXJLpZor0vfq0pUOu/Gtn4nkORHDXiY5NA6TUcWZOHQZ6jJdjp
 wUrEyE0fa73cpWBgnb3hNYOcYgStElQQGJV58FEtkyOuJoJHlefeJ
X-Received: by 2002:a05:6214:e8b:b0:6a0:a44e:c59c with SMTP id
 hf11-20020a0562140e8b00b006a0a44ec59cmr2989430qvb.1.1714746803390; 
 Fri, 03 May 2024 07:33:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGodvUHODPNbDin7oqzMGN/CTREVThpW0lw6b1vBf2DdZxDC6J8qfzO6SZFWIqLus4TwudmEQ==
X-Received: by 2002:a05:6214:e8b:b0:6a0:a44e:c59c with SMTP id
 hf11-20020a0562140e8b00b006a0a44ec59cmr2989381qvb.1.1714746802838; 
 Fri, 03 May 2024 07:33:22 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d3-20020ad450a3000000b006a0d22f23c0sm1247820qvq.61.2024.05.03.07.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 07:33:22 -0700 (PDT)
Date: Fri, 3 May 2024 10:33:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Jinpu Wang <jinpu.wang@ionos.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Galaxy <mgalaxy@akamai.com>, Yu Zhang <yu.zhang@ionos.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Elmar Gerdes <elmar.gerdes@ionos.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>,
 "integration@gluster.org" <integration@gluster.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, arei.gonglei@huawei.com,
 pannengyuan@huawei.com
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Message-ID: <ZjT1sPh5OaByQmAB@x1n>
References: <ZhaY2_cO6CrQFCt3@x1n> <Zhfxoaz9yNTx8Btd@x1n>
 <CAHEcVy7POArt+CmY8dyNTzLJp3XxXgjh3k8=C=9K+_cw1CSJFA@mail.gmail.com>
 <46f5e323-632d-7bda-f2c5-3cfa7b1c6b68@akamai.com>
 <Zi-1OvxA5MIHjklU@x1n> <877cgfe2yw.fsf@pond.sub.org>
 <ZjClMb-6MddpvHqQ@redhat.com> <ZjJgQcPQ29HJsTpY@x1n>
 <ZjJm6rcqS5EhoKgK@redhat.com>
 <CAMGffEnj54q1GAtB84dWGVR0hLPzfR1W8Fa2TeP22y2zTBRNeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMGffEnj54q1GAtB84dWGVR0hLPzfR1W8Fa2TeP22y2zTBRNeQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Fri, May 03, 2024 at 08:40:03AM +0200, Jinpu Wang wrote:
> I had a brief check in the rsocket changelog, there seems some
> improvement over time,
>  might be worth revisiting this. due to socket abstraction, we can't
> use some feature like
>  ODP, it won't be a small and easy task.

It'll be good to know whether Dan's suggestion would work first, without
rewritting everything yet so far.  Not sure whether some perf test could
help with the rsocket APIs even without QEMU's involvements (or looking for
test data supporting / invalidate such conversions).

Thanks,

-- 
Peter Xu


