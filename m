Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD5DE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBZN-00026i-Kt; Fri, 13 Dec 2024 14:43:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cminyard@mvista.com>)
 id 1tMBZJ-00026M-3P
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:43:22 -0500
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cminyard@mvista.com>)
 id 1tMBZG-00078f-Vt
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:43:20 -0500
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-467a63f5d1cso9884391cf.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mvista.com; s=google; t=1734118991; x=1734723791; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LKQCk7S7UFTeA8tIzyOC29n8UDVvmkc+qWh0TgJOewg=;
 b=TL0X3isrc/Mu+lq31JfPBhbpM7gT4Z3RTN246p3UJ2tDoPJcOzHzkLYOE6maXoNQ5J
 SOqTUYHGVn0ekedJ08IzOBTTDTXNT8w78/A942WWGcy5NQSPeJpsjLbXRWka6CPdkS6I
 B2mka1N9fUtFXU95bjmOfMQXm0cjUwdhEpaO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734118991; x=1734723791;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LKQCk7S7UFTeA8tIzyOC29n8UDVvmkc+qWh0TgJOewg=;
 b=HUIGspDn9BKPx0DkKe+hmONdzBsBg5vuG1Hg9YHa+ZMCPcYaVRF6amlkXexNWyZU1e
 Jc0PslTyWyOtjclM+tOeFuIkT6LS6Ja1wRBoD2keAgFE1zezHLeDMx7MI0T9Esuz3/AM
 COaVsLy1/oPh8mxXXUB065eDoKxC5a4o1OQFOQ4Cp3/KqyG//lFkf/5tVeMxV43a5/u2
 wj9yrnNkNkGGXaey+WVFLf/5VO1IlFTh1iLMduoAE17IhI3s+5SLtFGQ5zLed3x764C5
 Y1PuiJzF35SuU4tEoZKTG5Uir+Q/bFnK4MtS1Z7xKi3Vb+MawpFp+Lliy4CrGWPB4PwN
 0leA==
X-Gm-Message-State: AOJu0YwDfPrlzGecxTKVlb2vFNSpQsrzMS5Rq9D6dJ2pPcf3qDIawQsp
 q9/mgAqYhwyvHGHtDazFLfWShcSNM5enkOMMr5U4/3HilWOCoOjqo6gcXmv+O5ca8fFbRBehGr0
 p
X-Gm-Gg: ASbGnctj+rZDPJyPWcCPFYotrzxNgkL2wcy6kN2sA5xnnwN/RNUXWZaoweswFLSvzUt
 TVLgcpCW9ZYxcXeyopBjL9PZhXX3Fu72dikQB2orYMdj/S1OsrEN+Buf4egZUXUKhj1B3itRI9p
 WewJHTZb6pqn0lua8qwLnNtB1HBZlLh5T3a6PcQYAcRw2hdKFFeWZz+SumdBCfP0/lhTIQLCFbK
 juYkGly6ZycQOSFhAJUISO6a85O1Hh/KdAs64IMvEpj1rQIf4xSAmoGoH9baO0=
X-Google-Smtp-Source: AGHT+IHVzxzZk07T1jcS634ByBbO9D1BROlLMupkYK3RpKCLCEQQiiZfH7I9vM+l4VfWFH8jyegEFw==
X-Received: by 2002:a17:90b:3ec7:b0:2ee:96a5:721e with SMTP id
 98e67ed59e1d1-2f28fb66708mr7774528a91.12.1734118622100; 
 Fri, 13 Dec 2024 11:37:02 -0800 (PST)
Received: from mail.minyard.net ([2001:470:b8f6:1b:8995:3830:b502:80f0])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2a1e9aad0sm146855a91.15.2024.12.13.11.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:37:00 -0800 (PST)
Date: Fri, 13 Dec 2024 13:36:55 -0600
From: Corey Minyard <cminyard@mvista.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Patrick Leis <venture@google.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Subject: Re: [PATCH 28/71] hw/i2c: Constify all Property
Message-ID: <Z1yM17W5w0Rg9Fcp@mail.minyard.net>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213190750.2513964-33-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=sha-256; boundary="V0c3Ra55yziE4lz5"
Content-Disposition: inline
In-Reply-To: <20241213190750.2513964-33-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=cminyard@mvista.com; helo=mail-qt1-x833.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: cminyard@mvista.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


--V0c3Ra55yziE4lz5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yeah, a no brainer.

Acked-by: Corey Minyard <cminyard@mvista.com>

On Fri, Dec 13, 2024 at 01:07:02PM -0600, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  hw/i2c/aspeed_i2c.c      | 4 ++--
>  hw/i2c/core.c            | 2 +-
>  hw/i2c/i2c_mux_pca954x.c | 2 +-
>  hw/i2c/omap_i2c.c        | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index 3ae22cb052..2ea68c3090 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -1258,7 +1258,7 @@ static void aspeed_i2c_realize(DeviceState *dev, Er=
ror **errp)
>      }
>  }
> =20
> -static Property aspeed_i2c_properties[] =3D {
> +static const Property aspeed_i2c_properties[] =3D {
>      DEFINE_PROP_LINK("dram", AspeedI2CState, dram_mr,
>                       TYPE_MEMORY_REGION, MemoryRegion *),
>      DEFINE_PROP_END_OF_LIST(),
> @@ -1446,7 +1446,7 @@ static void aspeed_i2c_bus_realize(DeviceState *dev=
, Error **errp)
>      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr_pool);
>  }
> =20
> -static Property aspeed_i2c_bus_properties[] =3D {
> +static const Property aspeed_i2c_bus_properties[] =3D {
>      DEFINE_PROP_UINT8("bus-id", AspeedI2CBus, id, 0),
>      DEFINE_PROP_LINK("controller", AspeedI2CBus, controller, TYPE_ASPEED=
_I2C,
>                       AspeedI2CState *),
> diff --git a/hw/i2c/core.c b/hw/i2c/core.c
> index 4cf30b2c86..4118d3db50 100644
> --- a/hw/i2c/core.c
> +++ b/hw/i2c/core.c
> @@ -18,7 +18,7 @@
> =20
>  #define I2C_BROADCAST 0x00
> =20
> -static Property i2c_props[] =3D {
> +static const Property i2c_props[] =3D {
>      DEFINE_PROP_UINT8("address", struct I2CSlave, address, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
> index db5db956a6..80c570fd10 100644
> --- a/hw/i2c/i2c_mux_pca954x.c
> +++ b/hw/i2c/i2c_mux_pca954x.c
> @@ -211,7 +211,7 @@ static void pca954x_init(Object *obj)
>      }
>  }
> =20
> -static Property pca954x_props[] =3D {
> +static const Property pca954x_props[] =3D {
>      DEFINE_PROP_STRING("name", Pca954xState, name),
>      DEFINE_PROP_END_OF_LIST()
>  };
> diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
> index e78505ebdd..172df135f5 100644
> --- a/hw/i2c/omap_i2c.c
> +++ b/hw/i2c/omap_i2c.c
> @@ -511,7 +511,7 @@ void omap_i2c_set_fclk(OMAPI2CState *i2c, omap_clk cl=
k)
>      i2c->fclk =3D clk;
>  }
> =20
> -static Property omap_i2c_properties[] =3D {
> +static const Property omap_i2c_properties[] =3D {
>      DEFINE_PROP_UINT8("revision", OMAPI2CState, revision, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> --=20
> 2.43.0
>=20

--V0c3Ra55yziE4lz5
Content-Type: application/x-pkcs7-signature
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIINIQYJKoZIhvcNAQcCoIINEjCCDQ4CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0B
BwGgggpVMIIFXzCCBEegAwIBAgIQD/rh8xorQzw9muFtZDtYizANBgkqhkiG9w0BAQsFADBl
MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGln
aWNlcnQuY29tMSQwIgYDVQQDExtEaWdpQ2VydCBBc3N1cmVkIElEIFJvb3QgRzIwHhcNMTkw
OTIzMTIyNTMyWhcNMzQwOTIzMTIyNTMyWjBqMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGln
aUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29tMSkwJwYDVQQDEyBEaWdpQ2Vy
dCBBc3N1cmVkIElEIENsaWVudCBDQSBHMjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBAOqxRa06rLwKBvrDb/qQ8RtXfeKA9o0A42oZbLF4GYr4Xdt9JE8r3PJRIOUZD1U3mEln
4S/aZoS54Q+5Ecs3q2GGT/Z82VeAPLeGvJoT0LS5t/zXeUcbMuDFWgyj33kiesnuusnOWvpI
SoxN+oBH4oo0+oUiHI65mMjMAlb93x6sabh9kKvHQvHC4x2u7wYv5+NXjnbOhJS/1NjGq+ug
LMXeldFMz0O5qFIDpn3aQGU0htyJQ2SZyxEqlUrgunsrYj9wgfW7XuhAi2j0y5d9oMT0SuVe
KFFnQhTEk5B3fq+OBOW0AU2JdW1r929UtRbAr8RpLt05WI2G2RNVVlHYaU0CAwEAAaOCAgQw
ggIAMB0GA1UdDgQWBBSlYiBQ3LtbV5etI4814lRsqX75TjAfBgNVHSMEGDAWgBTOw0q5mVXy
uNtgv6l+vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwTAYDVR0lBEUwQwYIKwYBBQUHAwIGCCsG
AQUFBwMEBgorBgEEAYI3CgMEBgorBgEEAYI3FAICBgorBgEEAYI3CgMMBgkqhkiG9y8BAQUw
EgYDVR0TAQH/BAgwBgEB/wIBADA0BggrBgEFBQcBAQQoMCYwJAYIKwYBBQUHMAGGGGh0dHA6
Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBFBgNVHR8EPjA8MDqgOKA2hjRodHRwOi8vY3JsMy5kaWdp
Y2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURSb290RzIuY3JsMIHOBgNVHSAEgcYwgcMwgcAG
BFUdIAAwgbcwKAYIKwYBBQUHAgEWHGh0dHBzOi8vd3d3LmRpZ2ljZXJ0LmNvbS9DUFMwgYoG
CCsGAQUFBwICMH4MfEFueSB1c2Ugb2YgdGhpcyBDZXJ0aWZpY2F0ZSBjb25zdGl0dXRlcyBh
Y2NlcHRhbmNlIG9mIHRoZSBSZWx5aW5nIFBhcnR5IEFncmVlbWVudCBsb2NhdGVkIGF0IGh0
dHBzOi8vd3d3LmRpZ2ljZXJ0LmNvbS9ycGEtdWEwDQYJKoZIhvcNAQELBQADggEBAHZrbCQC
o3MAIqR0kekGYrC70EAGRDRq11COufNEXhcpv3YH6BMhUoVinPPNgfo5HPrZAFrLK/KPXYdJ
dgkASGsINabAfY2ljUaJwKlpIewwjS6KuGEn59MgidaAUPh6lbetIoRsLhCqCzAnX1aL99fj
CMf4NMWLUC8TqotnnrKNuw4JSjx4fcQs+U5T1bbgnyDx+8ybONuIEDvinHdKDu2VjoECzez2
y/1IVTPlh57zBfjHJQFqLWzHdou8M+ucdJtr2swXII6s3nkq4pfEn7KnbzMS9quFSuyOGILc
g/3qVwaHNLM5R+8nB5gPI5+u5Uh56w1i+9Ds1pjYAiTHdeUwggTuMIID1qADAgECAhAImztE
U4o9odkEsuVgiJc8MA0GCSqGSIb3DQEBCwUAMGoxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxE
aWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xKTAnBgNVBAMTIERpZ2lD
ZXJ0IEFzc3VyZWQgSUQgQ2xpZW50IENBIEcyMB4XDTI0MDUwMzAwMDAwMFoXDTI2MDUwNjIz
NTk1OVowQjEcMBoGA1UEAwwTY21pbnlhcmRAbXZpc3RhLmNvbTEiMCAGCSqGSIb3DQEJARYT
Y21pbnlhcmRAbXZpc3RhLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJm1
ZE9brEiQnF7EKiV+aYzHyqPFJ+z1wwdJ4wvNiwUCgXJejBxFj04Z7A62Yx6Sp59vfjbo05eA
IOyaLOFp3vbMBQAe8Qe4XrFv7wPcKZxwS+sgCuBvNs4NVGKYGjiKZW8WPq9ZcEl5BM8BLMrl
rchAUHJJcMdcEJUsed6rIB//EtnGOe74/vR1Tz3sN1WzC1Wa9COvcbLgVvWC/o4WysUfC9+f
9/5JzAiib7U7S/iRigkmEahibZgYKB7y6F1v9hxUwHxfa7GtJ8cv6LtRcPLhAO86GgXMfpgq
k3fxzQu8uwACpINbmQNLcRzg6mHFDYRK3mFp4puUnHO5EUJ8RgUCAwEAAaOCAbYwggGyMB8G
A1UdIwQYMBaAFKViIFDcu1tXl60jjzXiVGypfvlOMB0GA1UdDgQWBBQiHrUOKuj1vJe3OXAz
gOP5Qbl2FTAeBgNVHREEFzAVgRNjbWlueWFyZEBtdmlzdGEuY29tMBQGA1UdIAQNMAswCQYH
Z4EMAQUBATAOBgNVHQ8BAf8EBAMCBaAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwME
MIGLBgNVHR8EgYMwgYAwPqA8oDqGOGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2Vy
dEFzc3VyZWRJRENsaWVudENBRzIuY3JsMD6gPKA6hjhodHRwOi8vY3JsNC5kaWdpY2VydC5j
b20vRGlnaUNlcnRBc3N1cmVkSURDbGllbnRDQUcyLmNybDB9BggrBgEFBQcBAQRxMG8wJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBHBggrBgEFBQcwAoY7aHR0cDov
L2NhY2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZElEQ2xpZW50Q0FHMi5jcnQw
DQYJKoZIhvcNAQELBQADggEBADkBdRyx41eUGmsYXBXt3WCsYeDr26rJL7lbx2PvqaZyRCJm
J9CN2TljF0YHsXSPU+un1RfUlYz+PtcNFIqNuSf3N5fGU0bEpSzXozd/nZ32yWFLkd5CzYyN
F1xrpbyP2a87jKM0uqEHXZFl7NPiAfEchjFCddciHTOXjN66L+kJ/ZsOoNJLG8yFN401EGew
Nk8z/hJjWqR7DG0/YWn9h7jQ5SmqkqyhLwTO9s6KoByacWuKpKWSc/DaOuWmROlROrOA1hD8
0sKqC6jGeLxNpiYzSwBy8qKF0weZdhcHUeO1HOm1csrvWl1UghnlR7SLir3bb5LiesTVvSuR
Q3aDywAxggKQMIICjAIBATB+MGoxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJ
bmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xKTAnBgNVBAMTIERpZ2lDZXJ0IEFzc3Vy
ZWQgSUQgQ2xpZW50IENBIEcyAhAImztEU4o9odkEsuVgiJc8MA0GCWCGSAFlAwQCAQUAoIHk
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTIxMzE5MzY1
NVowLwYJKoZIhvcNAQkEMSIEIK1q2FdyBZAt4OYvEEkCc/geWdb1QwEA+/E6fScZ7bG3MHkG
CSqGSIb3DQEJDzFsMGowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIw
CgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0G
CCqGSIb3DQMCAgEoMA0GCSqGSIb3DQEBAQUABIIBAJLnbdACnJNCy6Vx1eTpm0Vi2Sd5jfSJ
QDha6r0YlPSf8KsM+PUilTTa8mF/Ur7MFcJ65/zpKfoVD3SXDqlD5p5YbwUFHWvqh/UYv9Px
j0X+xqRCLtWSs6MFL2dCXxztwqpCAqeiE5cjn7GxntZ4hmyLWPGxhpLNDUmw7H8VDDHklLcG
QsvV98QUlAYuiSc8F4Os1/7iR6RxO55iLPiSm8PgTqx6E2UUsHEzZ9lB5S99bG/zJ6mk4Tc3
fvqFXsnKYAGzPzlg81FvILt4wk/93sQzMIvqtdefUBiI18EnUqg6VSduh0t2XL0cl6xtpYts
ElE/+4dgGB6CqC+UbLLqq6o=

--V0c3Ra55yziE4lz5--

