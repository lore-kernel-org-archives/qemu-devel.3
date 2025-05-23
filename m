Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A753C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 17:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIWMY-0007Vb-JB; Fri, 23 May 2025 13:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uIWMQ-0007VJ-Dt
 for qemu-devel@nongnu.org; Fri, 23 May 2025 13:39:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uIWMO-0006Tt-Av
 for qemu-devel@nongnu.org; Fri, 23 May 2025 13:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748021945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ac1l87QhKCEpZIe765wfSm+TqisFN5WT8vuthA77NFU=;
 b=X+utMQOgDQkoIpERRm9PexnYJGyLIbiEVE+ZtM/3XXOdnGkEOkv6hidzXJp6fXHCCXYgqt
 qYjrasD8Eq/XPNj8zq8As8WtEI4cVx4f1FL2zBo37899OFgk4kG3/S7PquXKnK73Dmp3ge
 2uC7/SfEet1pBk4lY5Qp16WAPpMpP/8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-nfCh7h_5OSu0BDgQcyQnEw-1; Fri, 23 May 2025 13:39:02 -0400
X-MC-Unique: nfCh7h_5OSu0BDgQcyQnEw-1
X-Mimecast-MFC-AGG-ID: nfCh7h_5OSu0BDgQcyQnEw_1748021941
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-231dfb7315eso732175ad.1
 for <qemu-devel@nongnu.org>; Fri, 23 May 2025 10:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748021941; x=1748626741;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ac1l87QhKCEpZIe765wfSm+TqisFN5WT8vuthA77NFU=;
 b=j9Mm9pDlw9rUm/AP5bcxkKi2EBKYD8GfG3jNJ14KoSrPCWI0dc+1heyVEndmhL+hsQ
 g04yUqpu+m5rwi1SBXkoUIvxsK2+Izf3gufrUweV+y+T/vT934Qspf+PCtJIDoGQscqp
 DX92SUnv78Xy/cBZTYRZy6B2Gtpq/hxtoJjNNBy0Kgcz7a9tME+agKY4Za8iEGcMcZzX
 Fxv5bDniJqVRfEFfM7li5qwJ52DUsI0+i616pGACrOY61qunwvb75/tlHTepDR6F1GHO
 ItbH9kXpG7s9d2tOykWvnpkD4sJimOhbUAeFVuG2cYmQmW8No3LiwrFJW7uu7d4pQFtT
 OIzA==
X-Gm-Message-State: AOJu0Yy9mWWU/1U4HZExiz8RExXod8/i1Z2Pw9VIWAaSWfllTulveryA
 DQIzwwd/GkHhIj8CJ2QwjF06RmKksdRnZt4yVmru6jQA0eJbcJTGY1Vx31Tlgx1PFg5cg6F1WwN
 9mzknLG65I1I936pQyAvODLIIZktImPbGLQFHdz9TiXhp56twnHqmoRc8CpO0YQZnNNwUtU6qdy
 FrGbUf+SVaQVlgXC5Qllgq32QC6w3PjU8=
X-Gm-Gg: ASbGnctUgEYIWk7Nu3T+em8+tdJS8hMtlEWfNI6ouvTDLscnyFRShH8Vwx8YALUwfTo
 +TLbZuLCY2HZZ/g0FRmSX0doDrBQitn7ei1bQtJRfLXCb91UDnBNVCRBE5SnF7qogms7MvOjvX5
 MXZu0jWJGW723Be3MQncBxBseC
X-Received: by 2002:a17:903:988:b0:223:66bb:8993 with SMTP id
 d9443c01a7336-23414fd6e97mr3289095ad.43.1748021941061; 
 Fri, 23 May 2025 10:39:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGedlqoYMJRjvgFkpBb+20zrbdY5cIwF2lBK3rv/+86XRytRjAHjDSLBLjAnUdr0ALEfor2o3R3dnRfxEfOHQ=
X-Received: by 2002:a17:903:988:b0:223:66bb:8993 with SMTP id
 d9443c01a7336-23414fd6e97mr3288675ad.43.1748021940537; Fri, 23 May 2025
 10:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250519170055.3693275-1-jsnow@redhat.com>
 <20250519211718.GA58576@fedora>
In-Reply-To: <20250519211718.GA58576@fedora>
From: John Snow <jsnow@redhat.com>
Date: Fri, 23 May 2025 13:38:48 -0400
X-Gm-Features: AX0GCFudN0yUZ_wIa8tw16VQTxjt9jnVAQHu8oaOQVCMsHervVaOw-VQavKwGWY
Message-ID: <CAFn=p-aaeXTjqMmPpH3_-RwcOHbqnbFz4eztnA3V=jD9cKhUVg@mail.gmail.com>
Subject: Re: [PULL 0/6] Python patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000d3701f0635d112e3"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000d3701f0635d112e3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 9:38=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:

> Applied, thanks.
>
> Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for
> any user-visible changes.
>

Did these get dropped? I don't see them in origin/master.

--js

--000000000000d3701f0635d112e3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote gmail=
_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 20, 202=
5 at 9:38=E2=80=AFAM Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.=
com">stefanha@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">Applied, thanks.<br>
<br>
Please update the changelog at <a href=3D"https://wiki.qemu.org/ChangeLog/1=
0.1" rel=3D"noreferrer" target=3D"_blank">https://wiki.qemu.org/ChangeLog/1=
0.1</a> for any user-visible changes.<br></blockquote><div><br></div><div>D=
id these get dropped? I don&#39;t see them in origin/master.</div><div><br>=
</div><div>--js <br></div></div></div>

--000000000000d3701f0635d112e3--


