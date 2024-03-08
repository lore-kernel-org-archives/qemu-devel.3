Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF1FC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 06:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riU8v-0003rD-Rm; Fri, 08 Mar 2024 01:55:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1riU8p-0003mJ-3f
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 01:55:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1riU8m-0005Dp-71
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 01:55:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709880935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t7ggymyTbzzQbMJ4GHFdw7X6PQcf1ITQU8Uxp1lzpAg=;
 b=Y7IvHdAkE1bRPZeiPaAiUk77i2h2xSUiYvyi2kF8cF1V4Z3DJoRY2Ltyl7PVVKF6bGqLGX
 qs4MJHgsRzE1N3JLXT51SX9kZmTiRIH6xxoZyTul+Ov8s+F/T5GpwLKd5IiK4VrF8urrfU
 4O0vuHPksSn5hZPTvZzwU6NmAeCDo/w=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-iMDZEXIINDy-p0VCUu5K4A-1; Fri, 08 Mar 2024 01:55:32 -0500
X-MC-Unique: iMDZEXIINDy-p0VCUu5K4A-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5cf8663f2d6so437993a12.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 22:55:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709880932; x=1710485732;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t7ggymyTbzzQbMJ4GHFdw7X6PQcf1ITQU8Uxp1lzpAg=;
 b=uV0plgxwOyjmFQ2OeNqaPRYOi1QZgR4iyi2rRH6nDtQDu1z7sSuY0R9oILe3xkKkgn
 Ij3bekejFSPKMpbmnL4sdb98YE7h6oAZ4BxJqaXLSHMpqBJ/euhuqtv6hEomuoC77eMs
 7bmH8I54YjjHkDCewSibCLk1XQIgFOMjFNm1l8r+K2VNNE1DzvwCKuxZfnqa4GUVpv8h
 6sJj+VbApetDMD5/FjYqr59Z6kRyz1YxpsPhfkw0WggIZnf3x9SkCaz/zj9mntZTCAYv
 vH02NQbxIz2RRSMP47rWw155VqT84LNV+7dQwwVsh8m+YjMYeCIN7VTtopdqBhA+8Usn
 VO7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvmNixtThryukZ6BEytWTZqAGrb/BZMIQn59+zMV0xwvDSlDlB6L3Grj6AjgHbf649oEVH12Wa6MJ41x/wDU44TbTR+nE=
X-Gm-Message-State: AOJu0YwDSXP7wx1TbD9WYh4jzzpLo0KbB+jOtgUx5/9FGwd+ityvlUG8
 OQ66DkqX0rrdwUc2rZlNG1Ti+LY9cxD4Is7n29wit1dv8qbQdbx9nwcN2Jr8eGfS2iIgWK7SzTl
 oq1knGxZRUui5hVLk0XhzM6AeeAMDixebOLAeRgC1dViZZQ+4tZiR
X-Received: by 2002:a05:6a20:9188:b0:1a1:6ced:a0e0 with SMTP id
 v8-20020a056a20918800b001a16ceda0e0mr1568518pzd.1.1709880931798; 
 Thu, 07 Mar 2024 22:55:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMJXU9cfyjP16FretCsce+tChHBqhJ8dcUdwjLxJtixenckIYYgEWhciHsx19yWCJTLYDJMA==
X-Received: by 2002:a05:6a20:9188:b0:1a1:6ced:a0e0 with SMTP id
 v8-20020a056a20918800b001a16ceda0e0mr1568500pzd.1.1709880931437; 
 Thu, 07 Mar 2024 22:55:31 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 gt17-20020a17090af2d100b00298cc4c56cdsm2553696pjb.22.2024.03.07.22.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 22:55:31 -0800 (PST)
Date: Fri, 8 Mar 2024 14:55:22 +0800
From: Peter Xu <peterx@redhat.com>
To: Yu Zhang <yu.zhang@ionos.com>
Cc: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Het Gala <het.gala@nutanix.com>, qemu-devel <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, Jinpu Wang <jinpu.wang@ionos.com>,
 Alexei Pastuchov <alexei.pastuchov@ionos.com>,
 Elmar Gerdes <elmar.gerdes@ionos.com>
Subject: Re: Problem with migration/rdma
Message-ID: <Zeq2WqDuBbKKNWPN@x1n>
References: <CAHEcVy7HXSwn4Ow_Kog+Q+TN6f_kMeiCHevz1qGM-fbxBPp1hQ@mail.gmail.com>
 <04da4267-8fe8-4653-90a2-f64e3be64037@linaro.org>
 <a0d9e2c2-3687-4b7d-8fac-887ce262c38a@fujitsu.com>
 <Zek2UFoAyVrC7yh6@x1n>
 <CAHEcVy4L_D6tuhJ8h=xLR4WaPaprJE3nnxZAEyUnoTrxQ6CF5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHEcVy4L_D6tuhJ8h=xLR4WaPaprJE3nnxZAEyUnoTrxQ6CF5w@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
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

On Fri, Mar 08, 2024 at 07:27:59AM +0100, Yu Zhang wrote:
> Hello Zhijian and Peter,
> 
> Thank you so much for testing and confirming it.
> I created a patch in the email format, unfortunately got an issue for
> setting up the
> "Application-specific Password" in Gmail. It seems that in my gmail
> account there
> is no option at all for selecting "mail" before creating the
> application password.
> 
> As it's tiny, I attached it in this email at this time (not elegant.),

I ququed it, thanks!

-- 
Peter Xu


