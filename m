Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE56C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 07:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAP8h-0002eN-0c; Fri, 24 May 2024 03:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sAP8e-0002dZ-LV; Fri, 24 May 2024 03:14:52 -0400
Received: from fout2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sAP8c-0005mb-MQ; Fri, 24 May 2024 03:14:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfout.nyi.internal (Postfix) with ESMTP id B3087138010C;
 Fri, 24 May 2024 03:14:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Fri, 24 May 2024 03:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1716534889; x=
 1716621289; bh=UMLdRxRR4XtIRl8JDOvih2YCP0AldqLSoVyc3dEa4O8=; b=C
 MqXtfIv5s/OSvQ/Lz/pQbGIxlzfbki7qkrBJtNdYC1OIAmWUq6nyNwi53naiyWCL
 544KLHzct6JluMfCZjEmSoR8BTmUMmENZ61vBXJ0/+DpFmWOFmQj0NuWtxK/7438
 eZzDooLree+TqTUgFFRX+t5xWy86/8HrKEGuH6KgJTmKrr4Z0RqoYVSlXTA9mq2W
 yEsukxf2rPkz0tEcqoecydhiPUQbz7p/z3X5yNsABKwrXOwnAyApACVX0Q9lFce5
 hYaItn76s/3eE5BjgC0UDf7Y9/D5QSwClD9Kl/jMirDh9HBghB+52bct0ER0yoj1
 YGu130KQfK5t9ekp62O4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1716534889; x=1716621289; bh=UMLdRxRR4XtIRl8JDOvih2YCP0Al
 dqLSoVyc3dEa4O8=; b=AjkcxBWKxxQPc33n4PqoFc/PWAAeMyMIUDiU+WWymZDI
 kia+suAxEO55s1PMoqmlnvu1XmolvXJ9f+znurHJzYW942s6KpIqgRCtc6eEcsET
 pCgIeaRXRtgR90UITv8XhDRFVHG7xFyaXZqf7SFGi3myJUas04m586IjiYbZqnS/
 tCWyslHZTGllvjo2mnXwJ73kJ3YVnZ9W/5l1fJW85coeJFH1AKzYsx7RCskVbjqx
 6ffIYofJpmiY5Lb45umzR0bw84Cho4QhSV/6ifLXZFpkrBHJPURpfv2kwy9xo6Fl
 vl1axf53XIeKi8N3lVmV6JiFX8a9gEN5/Z8MCByAbA==
X-ME-Sender: <xms:aT5QZsNnZB7Cm8GDfGKw6cV4tI47GWGCkd1sbd-y9dlB0u5f7oeKtg>
 <xme:aT5QZi98sy-_0yxquuGjz6I3pRBOda9sObnwCdWzLbVrkdG-hEeHY-IneYBVHNAQZ
 WrrmZ0_LZhGdw-Rz4w>
X-ME-Received: <xmr:aT5QZjRyssX7sgR1h7nEpilIy_jbMAbq2OeHSFzds3V8yzZdWU5tNwRKhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeijedgudduhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgr
 uhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrg
 htthgvrhhnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteff
 ffejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 hithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:aT5QZkvEaCR3Ddx7yoaDErHA2kY8BM7ypbB7N4UX4bu0uxAOJeyrLw>
 <xmx:aT5QZke6XtxkdI3F1G7Qx2i4EKBBnVVe1Ssyp-9sdNqjzVSzXG-xQA>
 <xmx:aT5QZo22C7ycsv0k0BuQdhxSlAd5iR_j23rp92MzLMitfDGVdqM4mg>
 <xmx:aT5QZo_5mJn-XCF4elKMonVZKTBuc4GOgJrqykxKw5jp0kP1-7EfXw>
 <xmx:aT5QZo82DrxkFfJMH6CbYtD1BTHdYoOB7-7SuVgCiIT_q1Ef_cCguuHb>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 03:14:48 -0400 (EDT)
Date: Fri, 24 May 2024 09:14:41 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com
Subject: Re: [PATCH v3 06/11] block/nvme: add reservation command protocol
 constants
Message-ID: <ZlA-YYmEkRAW2lU_@cormorant.local>
References: <20240517095218.3107672-1-luchangqi.123@bytedance.com>
 <20240517095218.3107672-7-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FORsj0r+kP8uInSb"
Content-Disposition: inline
In-Reply-To: <20240517095218.3107672-7-luchangqi.123@bytedance.com>
Received-SPF: pass client-ip=103.168.172.145; envelope-from=its@irrelevant.dk;
 helo=fout2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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


--FORsj0r+kP8uInSb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 17 17:52, Changqi Lu wrote:
> Add constants for the NVMe persistent command protocol.
> The constants include the reservation command opcode and
> reservation type values defined in section 7 of the NVMe
> 2.0 specification.
>=20
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  include/block/nvme.h | 61 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>=20
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index bb231d0b9a..84e2b2e401 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -633,6 +633,10 @@ enum NvmeIoCommands {
>      NVME_CMD_WRITE_ZEROES       =3D 0x08,
>      NVME_CMD_DSM                =3D 0x09,
>      NVME_CMD_VERIFY             =3D 0x0c,
> +    NVME_CMD_RESV_REGISTER      =3D 0x0d,
> +    NVME_CMD_RESV_REPORT        =3D 0x0e,
> +    NVME_CMD_RESV_ACQUIRE       =3D 0x11,
> +    NVME_CMD_RESV_RELEASE       =3D 0x15,
>      NVME_CMD_IO_MGMT_RECV       =3D 0x12,
>      NVME_CMD_COPY               =3D 0x19,
>      NVME_CMD_IO_MGMT_SEND       =3D 0x1d,
> @@ -641,6 +645,63 @@ enum NvmeIoCommands {
>      NVME_CMD_ZONE_APPEND        =3D 0x7d,
>  };
> =20
> +typedef enum {
> +    NVME_RESV_REGISTER_ACTION_REGISTER      =3D 0x00,
> +    NVME_RESV_REGISTER_ACTION_UNREGISTER    =3D 0x01,
> +    NVME_RESV_REGISTER_ACTION_REPLACE       =3D 0x02,
> +} NVME_RESV_REGISTER_ACTION;

Existing style would name this `NvmeReservationRegisterAction`.

--FORsj0r+kP8uInSb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmZQPmEACgkQTeGvMW1P
Del27Qf6A7VqcXxZitSrzT51CFEst5j0V3rJ7MSzCuaxkdcb+qHBGfuWoy65iY3c
eDh36UoEAfQ8xzhwv/LEiam4cBXoUU9RR9bdun8HQ4oNG0BjcUQsx9Rjpe1ylSO0
4tBk2IpzY18pz5mFWv4+gHq0PfHySS94/5BCD1IQmUkFUjD2RtboMOlAmJ6bQKQo
JYI0sPnC+axvKiKnSTkDqQLt3kTp6+uzFNq67aL58Uk9fBSrr0j9d1FAxUnSchaq
1UVDRoGPrmffnl09awZEmwR/qL4q7cpGz7W4IkJXMv+kr9QX1Kz80WckbN2Oy3Ne
nij5PmvDfxc/M/Q+xuAtrelIpRAAKA==
=P5Ru
-----END PGP SIGNATURE-----

--FORsj0r+kP8uInSb--

