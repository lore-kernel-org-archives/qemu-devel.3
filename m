Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29AABD4662F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 21:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgVAp-0004JL-T0; Thu, 15 Jan 2026 16:46:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vgVAJ-00047k-F5
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 16:46:05 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vgVAH-0005eq-9u
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 16:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1768513543; x=1769118343; i=lukasstraub2@web.de;
 bh=XBFBd5qTDNbiTEjStg13UbhDcyu3FChLaPCvr/pDjXU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=S3Je5K7dZGxMkykHmS1BC5FMVthOsftKIEKnFggeUn2VwplIh3h94oWCraHi4brp
 dx8hpu8Vu7W+RyaXWHK326A22mqd8Vb+Uy1ckwhLyEJpZdMgGDMNUMx/vf3Fk60fD
 qrjn9exrKf5ErswDKEbVkB8gX4V6NJ8gzFoyD6Ce9Ed4fd0h0RJ8cqg80HlOSSc9v
 KZbisMMY1/gvk/io8w/qUiG483geVqRvgEl0R05xWnoE/CILUdn8uTLQtciiwddMy
 5q/YSENnd7yTkkg0Eg+rtmOjHcIF7srxl41wqLTF2sEmX3G7ixiMjGotCN7HMV4Pu
 qF1j/cvxgWmQlbRYxg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([217.247.100.70]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MP382-1vSAF041pU-00PO5h; Thu, 15
 Jan 2026 22:45:43 +0100
Date: Thu, 15 Jan 2026 22:45:16 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>, qemu-devel@nongnu.org, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Juan Quintela <quintela@trasno.org>, Hailiang Zhang
 <zhanghailiang@xfusion.com>
Subject: Re: [PATCH 0/3] migration: Add COLO multifd support and COLO
 migration unit test
Message-ID: <20260115224516.7f0309ba@penguin>
In-Reply-To: <aV1m_vneDzI_5WDV@x1.local>
References: <20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de>
 <aVPpg_LwlGFIPfen@x1.local>
 <CAK3tnv+f8b9fd_n9_6Od3f__ZuNUtuT2Q_MXszam_k=ooRPqyQ@mail.gmail.com>
 <aV1m_vneDzI_5WDV@x1.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/D0uwH9Sgf_kK54QhULLXHWX";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:w6gsi/0CWS4i3hTu3Ktt0Zd3+Mp2g87GU617Hpq8vfU5bjWS2qy
 970CMWA6wvZYSVhHcbFsjwNNQqk8UUBcq76n2xMlhbO5EhJLktQr7cSs1fFiQv+XIveC2gc
 kuVYUAl/lpQ7bpfuse6YLIOVUUPMLj9neyO14fC2J5cjE0EJCilv0P00uTnUY+KxYZrDTQq
 G8ap6ZxirVdR4F3M0U97w==
UI-OutboundReport: notjunk:1;M01:P0:ad0JoiRyouA=;gZI8+y+rQJjwSy3tdGObwtxbqD7
 tZSZqqV556Xl6e+WDi46Pms1rQvm3Dhtivtleg4GXMX/lZtIBDaq5N95KbsO9upm3AqHM86w0
 kW3GauMQsGQZnFngg6H3ZsyFYBJe3/PgIWGndSo/DrUj9jlgCptn7JzxYCE62ja5iL2HxjBxY
 52gdi3VbAEmU1DkpTnfDcCMcgSzKfu9BwmZMk9SR9FCH8CiukITWp97EWdatUcFE0U0XfroKG
 xDmIPXLPfI+o6RBXUnq7byhmZI+kVpDwzZ5VteIg8epCV8qHgYsUV8bzXkbXrUJZ4g4yoT0F7
 IP6nEGnxypvt7ZDDxbWnawUjePJTR2iWx/AbwVTaAxPByiOnyM6oCHdSL6b4h/ySOTEn7glf8
 DLiYEypF1+7UlAcAomOISMghlg4YZ85XC4PdmyWMofhksdd77zCOFSXrBLne4gHqyT1JBw+iw
 01MhVTYsCi11ROG+uvB33Yhzoo+Cyf7+LygBRwIDy09FiawPi1aXjRx+mo5pnzzQv/9A/PZjf
 mcGmyjN5XdJmFMSPk9jxY9vnMZDtc3K7mVcY1A6Ws2Q81N7yoXezinzyWyMuDIySpwLsvxxhN
 0eNIsUGynwKQ1uRAUrdiYnq4S9H81QPemuVBsVpCVMlVYWdGPWdF+9AkrrOlgdO4VdhjHS3Nm
 eopzAUJWlxK/qav5LobYh1YrTaJGSaNS5dS33WDUlG2vy3+kWIifYkuhiPpUUphAj2JBdQlmW
 Q9LK/Uzi1P7vJYuKadTb5ngrD/AgAcjJUhC5AK7cufZk64GTDXHIzXKTczSkTVUjvFLgz9rUq
 mzw/zRd4v+e49AXlKxYqpTqwNBHawpBArOGqiYmQNth1vVpv4NJ01Fw+j60keMmht92xts3xk
 BjARGycgZtkhEkUQ/t8HRn3UKOSzamZCA6v9laPDF9jGftrEhXArHqG5u2xIFD0H7xNsHviln
 FeDxR5wG71OA5kgZFICIY582/kypJjwK5SxWbhhjyFHJTLeVR63z4iasxHTPZ5dMUrHHPVDf0
 VAnIebpNyK0mR6DNPYWMYP/9Db8MN70cmc3pu9f+e/GywLBFXqUO1Lwp+0ZYmm+8M+pv33+8T
 x5v2svAXjDrEHmtDodG8FxCoZf7o7zaigMbfw2vDZJy1Tt+QvTiWmTKkl77a6eDmc8zOU78d/
 oNDbhM7eRtxQqmbPBtTnaCvJWsMvDwtHIfS5///PXWOd8C6wlMwdnGuHWi3elvmNNPkHVOp4I
 toSZgEGk1xoCbXcIHWqytEMiOeqBmLmT8ZQ8d1WaJRjc4onAhRS6G636J0pzeXXYd8qB3fAjK
 6T++3pN6Qyc9HFD2CozUFX7GDlGsH6I+AsUzvVMhvzx5YoqQ0pF2jCX4jIyn4xfPodHVY/Sts
 e6BDRlTfXUWbMUnmaydKfoG46ZmelYEmHzTfKZnm3tjvKlYBAFecb+JLYFV/eHVhUVqoMKYib
 djzqA2ZHFTK70OkV5KUxX0wJF0SCDUW4TB4PkY6bIMuAcGAXM2z1EWF4XCo5gpwiuwWfOhbLa
 cEUt3ecDaU3+JJsRL0TDFhWHBCKJGPZ7+DT2u08M42RGOazv5h06f0HtKrZxooEfSOpU0nq9m
 50jAsri6/Qj2/AmF4ghuYX8igjGTBYm3UKQpqRgW348t0YCwiLdHB9BKVS9PghDEd/Ujwa4aO
 EUcycE1SUzymxrp8Z4MBAuWb1B9J1WT/I9swlXNyBYk+2I5uR9jB/bl7It2QkXDof42/mofSB
 7Y8yKlN5M3J5p+UgnG3mDvaWw4gwzkmJos3odmnWcJHd8ZkbtBGXu1RK7bpwojzSIHkNlemjy
 iZluCmreech1ifHVkMnOodiQ1gVEqFW1c1Af0ubdGALXdWBR4VOHi5086pr799bBXR+TwA5TL
 E8OrMQrYUx2v6nFL0hqHSkxPHhp11CuUYrLl0V8/xANgkdJGUg+HB1/+gksc9551zmzP+6sOt
 SK6+tKEMwdY/X2frHNOX9ZhcUVn67YxesXrngsqE4Evs99U2rj9uctV2uZ8Dak6cK/ZUWUDF2
 5qSZ4JQoVcFX7Cp6QATLp7MpYuuCdOf7uey0JMETkLM73tVb+4c846NiOUI3GGuW+JWubcE8a
 EFVYaB/AtjtY1REg3YDV7mUXkIr0a7sgi4IGFrcNYbhLWHnQL/yZZYvfM8QmJSzxkNYmDBWyL
 BiTLWJu29gz5Y9zsZoRnJZZkUE49HviShIsMpOn4QbH7mWFtLxLWXitrsQB3JfyF46lQKaxJ5
 Eq0hI6lDN0LbPkhSMW6Q/NGYstoQs1vEQalNLzFjrChWIk+C3Ikt7wWWwnHLMhAzw23QO5DVb
 QfLrpaD01Xs85J5CBvckeMQe+5/o2nbonfDqutR6Mff+dj6AHIsxHmmMcJcU2rtjpUconxz9d
 by1GU65WxtZli87vaUdTowbbwHZsA6SQ9KRIJybovzNsNC18dX20FAIHn4ka1Bm7ucPbx2Qrn
 A88jh4aD9uOrJsYxEyvG4oIWxeQVop0MIhxeO6J1NKC6T5zLuarkYsUUiAct04LPufhKlRWOt
 Nf0zxR3Iu7x6SJW8lbsP2DKbhQxYJbf07SNct/eIP1r8qhLrF2UBvpNhPuUkHx6zsqyZSTR2w
 zCQLYozqvKdVVgWKn1zHDQZZgrrYDcNkjSPe00XeDoSd6m6ZPNY/9+gYwgQPBM3sBl0WneaNd
 ZpcIy56z4/0JgQ5Oi+t2BcL4Ya1WtiYutkm7REfjqlLs/4FWIqGyKXw2b60kOa9ziF8wlZQz7
 lRfiEYrKE2MOrr9aWddi3YHoYZeRwRS2v8S2jEW8qoqJzr+h/5u9JmtOsnnL3C7+4/DmbaZ8t
 nmgc5wRC2qgLo42tCQCkEginli3RMDRE0YJ8ObohJ7OedRZ64MYdPmtuGhmZkoMjJBbQTIi/b
 ta6COo5zHTtiB0s5G7UH07sNBkN0RKYm9AaxXjHS/CSnoCrplVk9Pg3DBF7zB8K4xlAliLWo/
 7GRoTrWZrwdtwdH3Fd5NZ8T2gn8Dpy+lF11delqc6N0tAL0N4QQSEwSFdZWB+eZtgsjFALWhZ
 xpw7pdj+BYuYdnzhL3hlNcl6iAOAs+sNy3goioDec311ad5RwejHaiLO2Zn+NcsIr/jTVoMYy
 IktGmvGg/Q3oQTSV9pzeEBoQG7/SpT90kbsbyBLSHAx1z5qnA3BG9WaO1niRCM9oTNHUrt3Ud
 GlwLM46flKVdfj8LxALJVwoZICciXadTpcCUTIHoFg8R00Glds/q8XtufUVPSQ5NO/k72XNAY
 K7d4v19825EW2ua65J2laEjC69lWrH2cNSKitN1rUq5CQXHgTWOChhrR/CKQS2bpVBqTU0Ffv
 FIE5/oi9cgSLnlj9Vbf7DpVr6GM/SFo6/S5MbuTcg0agDs8yHYypWI6VS79Mg3GiBmG03LNYI
 Bilo1bxH+eFy4OnyuvDUJIgEIZu1y0S+hhDYs0cdEDjQTMECVTxd8JFwe9w83aN4ux1gLIG7v
 psFrYX2bLWhYqurYk0RcT0eKP/2H3OtJjYVmlyZ+JkoHsSlnui555JqggpK6KLnyrPdQlD9qF
 Cyn1+uGnCoRIIJ24Jr7f18v7sNRNf6eNXYK8DTRKIew5rXWg6dze1Z+UKEE6jrPOHjYHA1J09
 IS4rMojCPRiIq7A0oC600CpFZ9OQ0SBDMn2cArnu3RrpuIKX/cPWzdXsCrzakZm0vvrmdHw+r
 TdMRzxmdx+ag9D3PEnXOVGhHWjbHdR8+WdP70QyCxfNPH39I0wFiAFcn1nUoPSLhgBJx2AMiJ
 Oci35H/15+O/wF7oA2nyx/xElw4r6dFggVx1DoizE1XdOFSNHx2YRFg03tmMEoub6HF5LCwGb
 TYpc/PnH0wL+3h30pOxGnCW6rDTPM/zTTEpklVPT5VzWPdgGiI9MU0ZMuroYwO/s0SJQdk5Oq
 mjJq5nbbwaXxcVNEs9HeubG9OIS4tLfaCMqavMu7/EXdtyBR+8yHaCIDRJzJ9U8ham9vSeWWv
 +ZRaSPbF17PJxAegG7CR5N59sga1GmHDn53Z0HXkS+RJIEpmfJVcJkPcwVw4bRoc0V/D2SOCH
 G4fCfaPri7c+yqgmT8FLbGq819DTTq1CjJKfwCRNLQzSkZR92wcihujlK3RBILLzKPU9ddweG
 cnLMSLFd0ilLZ4/G80jgCuV3Ki3lp+dUtfXtp//CoZ9ENMxdHA7DZnlL47QQ0SEei+XWfGFHv
 nIIQ53DK6a9ogv9FrEO3JOfIBMlPHhzWsruXEKt2foHTwjj7OfEVLhvWOndkLz85Mfbh6lfyG
 KIyyipwvxzn0xT7nrVJt/b51eLuiN28nISpKkHmtJW2snjL8mj6kDuFy6E1irDcC3e3hB9wqX
 6sI8c07OJ4Sjc1W+6khvgMp07YiSvC1LfhSmSMEsI646lVztJSslp08rNaqlJO1sUXK6HZRNh
 zMPazpX/Y2OdIFcKxG/7aJU0KW32Yi+Mbwd/s65W1N9PIrNKecrgc9wYbJQ53eIjlk7/g8njG
 7nZYW9kAX142qPulhF7b9wKy9xtizs0QVN3IxWlRQPVgvxyMw0xS9xHoQFpWY82Vpit9UK9F/
 M7O4WiezZKlwCvAbdyphy9s8paHBgnPnqTN4zIIwJebFcDe18zHmCJj+RmE35stBC8A8SUgpz
 jHNm4BgK7JzTVD/QKcEn+xZKqdlY3w36VKF4y4Tdtf371K8dzWH7VG6bzRUPQN38VUb4bVZlp
 Mxv8ZLVOI0MiuepvS3eAD8iE1rv112QX6EQ/CkM1pELcK608V7syYef1FIHCJAEpDMZGt1eAw
 XzEbh7AEnU6dVHS7YbZ7BkhKWKYuql+LYuMR5ITqT1pF2paPm25ff082iiWE2hfJtjpczS2Um
 8UY3xsDdc7beL4SPl3PDORU/fseH1xKwRTDVc7WBoLoP5+da7TyggownS7FYzZpNNSOSTR31X
 DFYjPe7DQEKmYl13NGF3ZjcGnvLz3euYtLyLlYQ8lU8RpIwFq9SlFyK45i9fWmtpLmXb38dWL
 Svw1BZ2NP7Z818hZFxbOBN9qIDSJmxe62RKh4JRPUWW2Wk+r4WmBlLC1EeN6ulU1eYFcqBeez
 3HSg03lC8aUSadXfKivtOL1ZvKLi/mWoe80MxH6KUPVIw245qW9Qocd99ufZTwIVojEm15ITc
 g1CH2iy2bKX+CxeT4bxHbDd3FHtFuV67OwLtGo2FGv9b5jQFt6ouYWJ3+Eow1z3OcwmuhT2SJ
 MIQgMTXc=
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--Sig_/D0uwH9Sgf_kK54QhULLXHWX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Jan 2026 14:48:14 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Sun, Jan 04, 2026 at 01:44:52PM +0800, Zhang Chen wrote:
> > On Tue, Dec 30, 2025 at 11:02=E2=80=AFPM Peter Xu <peterx@redhat.com> w=
rote: =20
> > >
> > > On Tue, Dec 30, 2025 at 03:05:43PM +0100, Lukas Straub wrote: =20
> > > > Hello everyone,
> > > > This adds COLO multifd support and migration unit tests for COLO mi=
gration
> > > > and failover. =20
> > >
> > > Hi, Lukas,
> > >
> > > I'll review the series after the new year.
> > >
> > > Could you still introduce some background on how you're deploying COL=
O?  Do
> > > you use it in production, or for fun?
> > >
> > > COLO is still a nice and interesting feature, said that, COLO has qui=
te a
> > > lot of code plugged into migration core.  I wished it's like a multifd
> > > compressor which was much more self-contained, but it's not.  I wishe=
d we
> > > can simplify the code in QEMU migration.
> > >
> > > We've talked it through before with current COLO maintainers, it look=
s to
> > > me there aren't really much users using it in production, meanwhile C=
OLO
> > > doesn't look like a feature to benefit individual QEMU users either.
> > >
> > > I want to study the use case of COLO in status quo, and evaluate how =
much
> > > effort we should put on it in the future.  Note that if it's for fun =
we can
> > > always use a stable branch which will be there forever.  We'll need to
> > > think about QEMU evolving in the future, and what's best for QEMU.
> > >
> > > Thanks,
> > > =20
> >=20
> > Hi Lukas and Peter, =20
>=20
> Hi, Chen,
>=20
> >=20
> > Thanks for this series, I will support for background info if Peter
> > have any questions. =20
>=20
> Thanks, I believe my major question so far was, whether we should depreca=
te
> COLO in migration framework. :)
>=20
> The netfilters and rest can be discussed separately.
>=20
> Now looking back at my initial ask in Zhijian's fix, I still agree with
> Zhijian on these two points mentioned:
>=20
> https://lore.kernel.org/all/b2eadde7-57e9-426c-8487-e500ba06410e@fujitsu.=
com/
>=20
> That is:
>=20
>         - Active users who depend on it.
>         - A unit test for the COLO framework.
>=20
> Meanwhile, I can't see how COLO would win if to be compared with some
> app-level HA infrastructure.. considering the overhead it requires on
> running two VMs and compare every packet.
>=20
> Lukas, thanks for trying to fix the 2nd.  I apologize that I still
> requested you to send these patches, without further raising the attention
> that I still want to discuss deprecation.  I don't think anyone yet proved
> we should keep COLO.  I do plan to send one patch adding COLO framework to
> deprecation, if nobody would stop me in a week justifying question 1 abov=
e.

Hello Peter,

I am a consultant on open-source high availability and fault tolaerance
solutions. I provide a complete cluster management solution with
automatic failover and failback for Qemu COLO.

Qemu COLOs lockstepping architecture has a big performance advantage
and it outperforms the market leader by 10x-100x in latency.
No one else provides this unique architecture.

I have customers that depend on this.

I occasionally get inquiries about Qemu COLO even without doing
any kind of marketing. So there is a general interest for this.

Also, Canonical considers providing this to one of their customers.

Regards,
Lukas Straub


>=20
> We kind of proved almost nobody is actively using COLO anymore in the past
> few releases.  If nobody is using COLO, we should simply drop it.
>=20
> > And CC Hailiang Zhang, although he hasn't replied to emails for a long =
time.
> > If no one objects, I think Lukas can replease Hailiang for COLO Framewo=
rk.
> >=20
> > COLO Framework
> > M: Hailiang Zhang <zhanghailiang@xfusion.com>
> > S: Maintained
> > F: migration/colo*
> > F: include/migration/colo.h
> > F: include/migration/failover.h
> > F: docs/COLO-FT.txt =20
>=20
> Right, this is also another reason why I think we may want to deprecate
> COLO framework.

I will take over maintainership.

>=20
> Since I requested this series (sorry again, Lukas), I'll review it today =
no
> matter if we decide to merge this series at last, or deprecate COLO
> framework.
>=20
> Thanks,
>=20
> >=20
> > Thanks
> > Chen
> >  =20
> > > >
> > > > Regards,
> > > > Lukas
> > > >
> > > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > > > ---
> > > > Lukas Straub (3):
> > > >       multifd: Add colo support
> > > >       migration-test: Add -snapshot option for COLO
> > > >       migration-test: Add COLO migration unit test
> > > >
> > > >  migration/meson.build              |   2 +-
> > > >  migration/multifd-colo.c           |  57 ++++++++++++++++++
> > > >  migration/multifd-colo.h           |  26 +++++++++
> > > >  migration/multifd.c                |  14 ++++-
> > > >  tests/qtest/meson.build            |   7 ++-
> > > >  tests/qtest/migration-test.c       |   1 +
> > > >  tests/qtest/migration/colo-tests.c | 115 +++++++++++++++++++++++++=
++++++++++++
> > > >  tests/qtest/migration/framework.c  |  69 +++++++++++++++++++++-
> > > >  tests/qtest/migration/framework.h  |  10 ++++
> > > >  9 files changed, 294 insertions(+), 7 deletions(-)
> > > > ---
> > > > base-commit: 942b0d378a1de9649085ad6db5306d5b8cef3591
> > > > change-id: 20251230-colo_unit_test_multifd-8bf58dcebd46
> > > >
> > > > Best regards,
> > > > --
> > > > Lukas Straub <lukasstraub2@web.de>
> > > > =20
> > >
> > > --
> > > Peter Xu
> > > =20
> >  =20
>=20


--Sig_/D0uwH9Sgf_kK54QhULLXHWX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmlpX+wACgkQNasLKJxd
slj+5w//SntY8UsmJCid5H7IbfRSWN2zCE+Bb1JMBuFt/d1BUFD99eDJsooX3ZDo
EYFs1lKf2uY3gCbnra3lzYzt4cCENbkX/kdS9WjyotGlZgkHN9RVtW2gBOJhur83
swbo6NFtZ+XT0wkyplFvh2xwqLy4TUKP7au2jQO1bkRGzvFuo5u9ft8Ja5Abw0Tr
jMoH2rA7Vh2dYNUrtlXST3hbH91akZtq0KneaqKUB5CLAY5/1rY5abRX0wElA2Zd
3alv7kOLTrIEKKMr+j+LXM5SpX2//4hXFt66b0Nm4+msuARsODXfphKj4On/vlQF
c2ebPASQXRnzIi77lB9rPIU5LXpTi6AueXms3JBs5wEYU2lhuGnSmTfSIe2Zjh5P
HJoen4UtP/JmMk4MjzBgGaijCugVUZ7gfTpDh5lMGY4osl9GSLRreYUXBC8IeScq
zM/eir6T8JMivhVt4rt1gLuZ/pDp9XxUoGnQ4/45vbEm/CIuH7pNpMZu0rtAMRwG
Nhm3VWMT8t7WhgZywv54WrNEAlj+e/9jYhwuRBmW4gbLn9vNlhuJKYZVDnYA6Pva
zKMjjN4lJ8kLdTe72OBuFVSiDFDz7OjSIlAH+QsDB6iP8XmpWtyPtfoHjBukRsP5
ZZFeJQ4R9mz5pBL0VmoyNddCPrnMazsZVdmjD0HSNs8fStiQyuQ=
=MdzB
-----END PGP SIGNATURE-----

--Sig_/D0uwH9Sgf_kK54QhULLXHWX--

