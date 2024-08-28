Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41C9C54FB3
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 13:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjIhA-0005ez-5t; Wed, 28 Aug 2024 09:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1sjI85-0003wC-T8
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:50:29 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1sjI84-00052H-73
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:50:29 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a86acbaddb4so618629866b.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 05:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724849426; x=1725454226; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=02ptqi7SUr5ZLauUSAynEV+niDo0wYMb2imjWzIfsos=;
 b=cqKK4bqsykxOzaj6MfaZcs4c+nPGDdJ8TMUeLJbpqIQ8NOnQ4G0fDGg8oN0sNrqWSC
 BuKLhJYP8Vx4yvne9n5dnWLaia5g9E8QjgYFV2C/KM/vWT4C4fHA3ec07AFht26OFe/8
 S2opUKBGWhs011cBl3B37hFR4DsW9vYiUoXWqD3V67tk/pQoVXHMEnqJzE+S7EZM0MxL
 bj/VWis4XSv4NsXHN8nDZX9b4AgwYK15X13kjbKijQWIg61C4DWL9rCEMMn0GgvY1P1k
 2MdpwH1KgXW7JqFgv1m8iJnQK+dsQDwX9rQU3tjcH9wJl7WBiRvPPkqSq8Lo4tmwZxQo
 +5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724849426; x=1725454226;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=02ptqi7SUr5ZLauUSAynEV+niDo0wYMb2imjWzIfsos=;
 b=F7QPXLkMv1HCc2BVhyYyVkxu5hahTevL7O0HiBXPelYmdCDcy7G5n22a+UhBl90DTZ
 IExlFMBTB6a3Mi5ZmH4NcS3xrhA1daqxI411dFBp/jmbr90lvVsjGxPrX5LQD7zU29zo
 5vTa6o9CZa6Md9/AwRSv0XO62cHOp30z+OLuiOnf3ucT3kDYvgGVvD8Cc7QzC9fOZZZK
 BwU1s/k6e5R7LFRRzoeKBrdkY61xWuOM7ryqsxKrfLGhgFSDdeBzkvsjiDg6FSoQDfbj
 WSh2nxT4A2HIJTDmckBNqDmRfhfzn+aze54Xn5D64+e8rdXOSkh9O903CBJaL1X4AJYx
 cthA==
X-Gm-Message-State: AOJu0YyxR4JK0uVgjC9HVB9Wa5vVY4Ph9Zu681oAe+UL2928TXd5uTQs
 gnlTbKI10deqaZiV/Ve0u8CR/qxEI35WUTE545AxkEXghAFeJhAD8xVIyA==
X-Google-Smtp-Source: AGHT+IE29WBq7kuECyXBSnYy5BOdM5UYyHmOqSLSaXwoEhv5nCtwXNbP/Z67Hh34aQ5rzIHHSkE9DA==
X-Received: by 2002:a17:906:f59a:b0:a86:9880:183 with SMTP id
 a640c23a62f3a-a870a94fe3amr152284566b.10.1724849425906; 
 Wed, 28 Aug 2024 05:50:25 -0700 (PDT)
Received: from [172.21.179.178] ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e5878a4asm243765266b.177.2024.08.28.05.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 05:50:25 -0700 (PDT)
Message-ID: <d9a3044bf7d9c059fd7cbdb4e12400c11003ae28.camel@gmail.com>
Subject: Re: [PATCH 4/7] vfio/igd: add new bar0 quirk to emulate BDSM mirror
From: Corvin =?ISO-8859-1?Q?K=F6hne?= <corvin.koehne@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Date: Wed, 28 Aug 2024 14:50:24 +0200
In-Reply-To: <216d3028301937887bc684ac905c7088272930ab.camel@gmail.com>
References: <20240822111819.34306-1-c.koehne@beckhoff.com>
 <20240822111819.34306-5-c.koehne@beckhoff.com>
 <20240826103513.082360bd.alex.williamson@redhat.com>
 <216d3028301937887bc684ac905c7088272930ab.camel@gmail.com>
Autocrypt: addr=corvin.koehne@gmail.com; prefer-encrypt=mutual;
 keydata=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
 LwksVmgc9s79+9pSpeP5DbIeMzhrIK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 28 Aug 2024 09:26:40 -0400
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

On Wed, 2024-08-28 at 12:40 +0200, Corvin K=C3=B6hne wrote:
> On Mon, 2024-08-26 at 10:35 -0600, Alex Williamson wrote:
> >=20
> > PS - please drop the confidential email warning signature when
> > posting
> > to public lists.
> >=20
>=20
> Sry for the noise. I can't drop it, so I'm going to use another mail
> address to post my patches.
>=20
> >=20

Argh, forgot updating my send-email config when resending the patch
series. Should I resend it again?


--=20
Kind regards,
Corvin

