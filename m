Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DBBC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 21:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfRK9-0005F5-Py; Wed, 28 Feb 2024 16:18:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dfaggioli@suse.com>)
 id 1rfRK8-0005Em-03
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 16:18:44 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dfaggioli@suse.com>)
 id 1rfRK4-0000g7-Rz
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 16:18:43 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a4417fa396fso36874066b.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 13:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1709155118; x=1709759918; darn=nongnu.org;
 h=mime-version:user-agent:organization:autocrypt:date:cc:to:from
 :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=RSOKWB6cPhkB3HS4cZ6MoKlVadLwoUYEvBZ/c6fS3hY=;
 b=SGNzlDgGk5kwiGnIocdptTEVTpaU5VsqmS2jhPcEptmHOo9y1Kwm5u/5wQTqeOltRU
 mRbC+FjR6kms61czyeiWSlxyndmYzd7fmUC9G8N4uh8Rm4OWvBa4u5XhpMeF0r/rKcUf
 oAypqxuuPZxIr0HOKbJZZjQcaJiVb0a1UOWF7AratYzZiL8TeOEE9TbTbsoUFtsL3laH
 6xE1hFrxMpe9Id2O7X/2iO8f8sEC165tRWkQJDZf/JoXqn6rSRIirFvnJYsnjTUo5KOw
 PIUGqrpNq5NxkHZu/CYZQXAmatQAdSWb+bxraNLLJrWeWAedKP35rsnrUJMmJEWFczZJ
 Ry+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709155118; x=1709759918;
 h=mime-version:user-agent:organization:autocrypt:date:cc:to:from
 :subject:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RSOKWB6cPhkB3HS4cZ6MoKlVadLwoUYEvBZ/c6fS3hY=;
 b=uPS24kySGd/KHfc/zEP8abaaaA+N29bGdDYe9HLfhcfZLKdrsyotYZTYKeQfeiDLUV
 +AkThJBoT7zeuyGUUiCcDriQF2rE7ySnEH2iYYStJ6PtVrpfHDweTf8P/BaFDIsbxbqi
 kJQUUo8SakvYK+DagRFB4EFaH0+p81jVPqfAVn9O/Dri1HsDc72JxtOTYNuAWmyy6ppV
 TOi7yn7YXtpEw+myMuLkB2F6L1iHLf1EH2GfElD5lvOcAlGo4GWZIpAPuIHfLx67V0Uc
 /DZsgdD2ugu8A34iQRTQ1Yt+AjIwufmiFxcT6eV2T8leEDjwu6vG/rIlQm8tmK8y6+Sy
 xMiw==
X-Gm-Message-State: AOJu0Yy7RMGqHQf0Wq5BINt4EThbY51cYrLP3FKhnijhgvdDC5mGkY2t
 s8hU/5cQ9U8m/XKKoRZxlvCjcHbyAPcQrpXs1giug7wXkPGno4tAP8aUR9RaYk+ZWZAhCFoBm0s
 Ucq0=
X-Google-Smtp-Source: AGHT+IEy0Mdwo8k+rFF9Ea+ocpKJMll6sw6ja/U9mHq0vniFrluah7mXQMs6kbb9+0F+Cacx4oJBCA==
X-Received: by 2002:a17:906:495a:b0:a3f:384a:73ab with SMTP id
 f26-20020a170906495a00b00a3f384a73abmr80178ejt.71.1709155117788; 
 Wed, 28 Feb 2024 13:18:37 -0800 (PST)
Received: from [192.168.0.30] (87.78.186.89.cust.ip.kpnqwest.it.
 [89.186.78.87]) by smtp.gmail.com with ESMTPSA id
 un6-20020a170907cb8600b00a3f0dbdf106sm2237310ejc.105.2024.02.28.13.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 13:18:37 -0800 (PST)
Message-ID: <88e2bebdbfa4a9e29cedcfdb08537f2eb9654ce3.camel@suse.com>
Subject: No virtio devices in SeaBIOS VMs
From: Dario Faggioli <dfaggioli@suse.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Claudio Fontana <cfontana@suse.de>
Date: Wed, 28 Feb 2024 22:18:23 +0100
Autocrypt: addr=dfaggioli@suse.com; prefer-encrypt=mutual;
 keydata=mQINBFcqIZ4BEADwW0E1y+J8FG0kGAA0y5UqenJaGp9B6gpm6aAAVkKYBDreeasOb/LQ7OqYHbJpkEjDsEwS9K1/iCTtjSO02Klk0vW4T1rlRbjgtyCevHUwINQhYnwREWOkogeTAcrT+2tq/xSxl/sR73vgLtMSqYXsIY7Pqxbi9CF7irfA8A2gGvToXrQw7C6jlFJa+l1gGYclA9bc7TSJzIzTui9z4oA6R8Ygrl8ugf69vd9hxGavqvz4vRARAxFgucPs00Aj0WnUTzRuUAF7VHp4VZ56Z0I2gv0M2YVJYjTw+5YbgjzL92T8xPnyZ8q+DjiCDP+v2h//j3BOHtOWnkBmDFpYjix+JuV5J/Ig9icyMo67WrkTG7sK4wI28QLQMdoaZrYVA1mkYTWBCpWNbVAjMCS5vPKQVGh32OGsZ6qSMuGiynwDu5ksIDX16kx74agtF3stSM8BVOYJWaGbmMiMogd0lswYQU6Wx8Z5osMvbFLc+CQnavJqhg/UnqDvZ6TyWir5NJ3Wo+YQh22bW0zchpWeLrXelH5UxNGK/dM26/7gKzKe8T9SUIxaxpawHcpPBB35W4Xwg94bcSQeS5KN3Swblj+C2FkPu40KZ2gV+STkmxyWbUamQPf0Q5M8ih1cSopOwvsG14i5V8PqFH/JBbJUlrCOD6ZDdBStIeTLnuwrxYMjGQARAQABtDVEYXJpbyBGYWdnaW9saSAoY29ycG9yYXRlIGVtYWlsKSA8ZGZhZ2dpb2xpQHN1c2UuY29tPokCUgQTAQIAPAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQRLmyw6PdWGvRY+c4sWQniJpbhz7gUCXHiV1gIZAQAKCRAWQniJpbhz7uX6D/oCWVhNZe7PQfLxbGIPVaf2yMQM1zlUA62Xegv7dA1
 me5NbEcbGwJ0NvwcM6DLIxnVTbSMMA5M04flSFmrvjMVO6E8a9y9N+o27W
 S2snhZUufqj9LUf9KLWS/aRlnyWBGeg0ut9LUfLx874CEuHwJM/rjSzXTNKap2YD8zd9S1JTDZ8gUismod+TTh70r6xzibgZklcupECDgp2iwRUAqoEfj3rTqDFkVyySFH1OiP4NYx5TcivwkUML3UKedzdz3ZeANbdV2XpNGGWMoccRlJBgIhHJURm1TNPkXSTzEHzZkNE740ygQhMUu9zM8RoyQ09sR7a/z7EESPb4xitPqnbYd0EoLnZOquW2qjnM1xrULNbMATW3bYmWGtpjWpl6VY2caVy9DCgEimvlQLTkj0cAF6Cz/ZNj7xvN26ZdOch+ji9dDoPJBzjUfNZwEYsCc4l3wXmBnLZmF8kUZEtEOEECkP7nbNc2r+HUN1Zzs+DOmaWjniR7b65qShIDdvI3T/jd1sG59snXGUcIDu2MuARHMY0AiHaZHAAOnUu8317oPgVHepVkffi9wLkZtcv++aeU/OGZkgyCcX49wCLmUdgK2z2GJnT4QIKHKzpeVl3vx4bH0uZI6Zvv7qtZbZ+3Bqd5c/H1C9LbK/zbJAvu+yOcLQ00VW+SMPVaE1CHRIperQ5RGFyaW8gRmFnZ2lvbGkgKHBlcnNvbmFsIGVtYWlsKSA8ZGFyaW8uZmFnZ2lvbGlAbGludXguaXQ+iQJOBBMBCAA4AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAlx4ldUACgkQFkJ4iaW4c+6Z3g/+N3/dMZAjEEnBqhHr28Dg5OoQGxCt209zj50gTGIw09J0Dzg+tPILAC5IZzjGlEuQI4015N3bJpz56N2gIjT1B0Rxh+HMd+4wKz/TZ+rUHgwhIfBei9jDzlqD4Z+hSnIpPN3mqQ7as4RdBmC0WhFKY/BB4V/EDyZfXzCJAKv
 ysQFIsf3i0DJo1CC8hZK588dyAbB62Qh6ookOhfdTmEapcSHFjfd0osJiHo
 4+3kJP53HxNPvIWyxrbznrfVg6cHJOKKx5yowWYe4cEJcCLYCAy9UjGmTDEl5Rwq8J9kihQpGCtA2ivEcmIpj59JeQ5sv1IRcwamSxgylWvJR+Om3nz2Ma3334GdaIaeyb/dR9lyxB2fiBB8V6Avo+oJQniWqXxyJ0HhZkRBOTX7LtSzQFOnYKXz2mWRkZpclmztX3BqctB0Z/K1cm2KIcm+MBUqjLZeprfhFS9f3WCYOOSSLRvYRVSwXw8ImJYHqWbePQYD8LeAJ7Hs0kqhd/CtUDyUrwtwzzKRs/8wVSRCLHLTZiSZua8N1Tqo5M4t6wSeENALB2kFLEmlgApTghCj51kWpTzysL9RgREoKSgdsqwfzaQlZH490H1WIu1zedsdaigeJ7G6UIVWjTOwK59s1pEyrtz/gZWJUOJh77MspoF/mUjSXm6W9YAQu0pahk4KdbZKW0M0RhcmlvIEZhZ2dpb2xpIChwZXJzb25hbCBlbWFpbCkgPHJhaXN0bGluQGxpbnV4Lml0PokCTgQTAQIAOAIbAwIeAQIXgAULCQgHAwUVCgkICwUWAgMBABYhBEubLDo91Ya9Fj5zixZCeImluHPuBQJceJXFAAoJEBZCeImluHPuiZUQAN4FY5DlI11sTYcdG1VyLYgE76mek5ItP0ZblcSF0INr6O9jn3zWEgyr6pFzSIXu81WW2o6UJEeb5wJlbte00Oxlgwshg3q1/Zd5MshtAjGGcCvnnffrcyrbyi6cuj/KwvRQFGsaT3getrf5LqIuC/HJgd+4k+S3Y2qOjq6qPZLG3I58F/K+SjFFeoX2CJvZEKPuMf51TvrBWQMK7qAf0nCG0noytZpbm+lCcHdJmoQZozn0e+4ENLduDe8c4Fsi2Fgjvuc250mC8avBidX6M+ONJrJTW2iSiqaLrp7FzS5f6Sz
 RS7hKw9USmG7p30PFP+u2eBXfcriaIttlXgRcfQWZhd6c432wcssUlW1ykiq
 HBeElK0W3XD55RahdJwLnX2ycToXAYp1afOAk8l2WKP1euXxNAN+toXpFRZpJDoebFHVuBKzff5F9yaF6cN65FZrUUZeT/6UlQj7aEsRorozZpzJN2f/fa97PSR99+pOAmoAIs52tME4QTNExHCZJFvQTI2GxrFQV8qTfo7ZswjXDui84NbUhlYnGH3Qk/iMKWfCGt2GyGpWQFV14u2sstHIKIRIj7EmL2tEoQGaySvN9HAnNfrW1Sd/zkzr6Wy+sYTOABgkxOtwb/aVfVVnl1PhMiQfTXTvsX9m6e4ZXTxh+pnJgyx58PG1haeGDTGJetDJEYXJpbyBGYWdnaW9saSAoZ29vZ2xlIElEKSA8cmFpc3RsaW4uZGZAZ21haWwuY29tPokCTgQTAQIAOAIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBEubLDo91Ya9Fj5zixZCeImluHPuBQJceJW4AAoJEBZCeImluHPuAVUQANDzlRpfMMUtVvVQLtYIm06rJQhbjwd8UE1Yq5pwxfVUYHm5JmvDI9ugOl9gAo6O29Cfrmc7Om8x3ewBAjQymNCHMq+MYPNqyVZVfSMH9CEg8/btGhm4IdvjXkqTtX2uZLqjJ5tHGxYuUbeL7uQBIFgxEpvXuHlg6mixcpyah+pYmmt0LnCCyj2f4iTZXuGXLKvayskCO6+2s++jF5f2HbBGe0ZkwjNbbCvxbhnX9YdYVvWEMRxBVxEsN1+n+MlvNkWp/sfBddsS8v1FpoLg2uUvJMhxiRoqxZCHYK1q/Obn5dWfN5inq6GUp205MESiV8NbwFYxI5H+r3OqWhb2OcQDiBlepJ3PJzKrZEr+6MYwWu36/XGqFFz7rxD48+QdlUFi8CpPCw2hMAzap3e2QwmkPlSQqtANKXs89M2Gc88dkwAi+L/DX30
 aFiMx6KcJkD6Up15N2x6FZh9VT45C9xPa4/IFcNpswn9Tngyi7wR7bvY3/dae
 uSw6pzUARZ9IC6rRxVqf92gykLEfcIWGpYlKDmnKKMTSgGBycNwk6nzhfa3VLAtxrNfG6bvzwXTQE9UBOC+8Ogu+BUvbHlA9+B1pkThQLyo4biSYbvcUNsOqYtugWW3gy2ogAHHcRXiFxxz5hKdkVwCeQteIPaTeMiZckuktpC8ioAT//C1pmVpvtDxEYXJpbyBGYWdnaW9saSAoY29ycG9yYXRlIGVtYWlsKSA8ZGFyaW8uZmFnZ2lvbGlAY2l0cml4LmNvbT6JAjYEMAECACAFAlnqAncZHSBObyBsb25nZXIgd29ya2luZyB0aGVyZQAKCRAWQniJpbhz7rEeD/4s3ewT5VjgFTJGA3e3xRkh4Qz3Ri8mDZeyrwWw4dr5vZnAZMAG+NTaQMYLtcKg5DUsRBNGHUL5ZH70sBPYFMG2Fg4eddRVewC9cJ6sJBh97u8RXueBhu8GDinMkJZitnrCHR8mEKg8szWHIqM/ohsPp2FbUdsqqky1XGYNDdKHIMMQpEYVgBKWKFMDq08nzFrJrGeRgg1Gdsa9JoE9/rMpcwwnoy5z0Bvij0u8PoSp+aBJAgGWJPu+abJghc2V3sRR/vyZyPPNZKJyirPqXy2ZQVYrMM/jFsJsI2POz8uEq5v4lf5MnJZNas785F4klpzi+6LaIBVtNm6l8ANU8Ad+RKsgoMnAx46ClYYCJmC2luzIo4hxD5fDyCQOGSxp6S1ONbbxg5N/XsD4yuJ+ORzO/6BylBArRo7c2qHACD9qvu1VXIQn9/IbxznGOlCRv4xAD2mGzom/umsTpTWus4pjo3G1/f/rkK4PYI8Kxsfi+WPD986deQLScMQM5hYAb26apvjv9w0XYLQWY6cQKvquMVTdb5bIxddgr35PLdUd3DZUtOAmm1pdveD2EyerECOLp03MZXRO4J818to
 /tCCdXA3l2Osx6i9443aTew/QlG1qp7kWk24ZP1pgMSSuEaFmdcmeLdk0VKVev
 W3g5GzlS+FTdhuMz8WgVfkAJ0OEQbkCDQRXKiGeARAAmdNiVGXFw1HmDfVpIXk42n87pHXziq6rpQNY7sLgAjTmBpfYVDH0BjosCkflFximqZwdf9G07G76rBf5dEWLx+J5DV5NJVk5HF/c1vwh2LcLf3tArK+L4oG4yih+hPrNf9bpB3fmF1M0EUo8PTTdM0NnIgWruwCGjiUGiMfPcb5YWVLtBvE7RZZFPno+Flo0nrvaChdb9vSwaGOZDHrD5LskmRpR/N4ADVy1HDzHVDq/81XYBFlnmsvOpBgb4lXPwnNG1MFCPhdflao0zi8Qp4DDphIpy/4lDLbttD2oJgx8nWfZvK5MK3EGAsr6zYqCOUX02pYukWGP6izCO/dt4kuFOeU6rSMjnl8cx+1BefbkrhHYCRA5XjMJ0z83TMNdVu0aYxGN0QOEbrU14WTpzgxFxFabSkv68GDwhfbzTazXdm0TFfHwR+332IQv+cfoMzNCKc5g10tOMKBOQ+WnatqvB197VN2BYdKomwNAa6/X2iLpTeze6oEi2/mai8AE9S0eeDfLm13rkcwSwG5gWIQu3SV1FBl3eEgrA0IT4be5Yeo0u9PF/lLaSznA/i2uYBqZ32z/4ZhbPtNUxR4uoAOWYT4HxVaH3f2N6dgDnWzHxPz4k1uNVRWTbORf26xe20wuChf9oJCymk1cPJRTzvGYKMl5fc5OP+DfOND20SEAEQEAAYkCHwQYAQIACQUCVyohngIbDAAKCRAWQniJpbhz7jtqD/95JUDDPwv001ZkaQq1qdo0IQuScCnEeYy5jWPBg97KXrxpPEQ107cU8FoWAVENhgGtI0bRxOPXf/MP+X/P7v0GkmOSTBsECu27GYGfVq97cpna+Y+QK57c2e/CwGvAc7e6gddfBpJFDj2L3CV9VDecgqyQUHv
 H1hdD5A3sfkRxz+bYErg4kKp17XLH5BYB/amFMYMZ9zlM2sgHdCnLF2NcbJdRDv
 j+9HL6WDaQA+JFZt4Nnxse3QX5Hvwka4ASl0K7dqQYPC+V3VijKnR3MPVSqApYOsbvt7n+cSKzL22O0EecRYbOaEAoT509Ux7vZSbV3HXsY+9P+A4a/l3OC2lxfLtxNh0hoI54UPCwy3NRwHcy9I4x3KNE79QpuH1hSfCGonV4lLFc9SW0vehqi0U4TGw61FIHifrWIp/oRQxtSoQYu6tklqOOBPs7k4UAJqVoSdeLkiptsWvoplwQ+/c3Ph8cuxeAO993bIZu1SoMomZ3wFkWIOK0nqwF2iTB1R3GlUb/+BJvYsLBBE9/BQYLWd/w1ZBQkiGvoG/g6sJ8iimhN13tpqXm0Au/LybqAwNItz/fwaqaoq/tl5U1zofRUOascEdd1VeYRCwjxEfpAD/mjVACV4idc6NV1Z6e5GB0aKTJ8toQEStAfhHXom8XBqDvV6HpljHZlsuWGjhFSrkCDQRXKiGeARAAmdNiVGXFw1HmDfVpIXk42n87pHXziq6rpQNY7sLgAjTmBpfYVDH0BjosCkflFximqZwdf9G07G76rBf5dEWLx+J5DV5NJVk5HF/c1vwh2LcLf3tArK+L4oG4yih+hPrNf9bpB3fmF1M0EUo8PTTdM0NnIgWruwCGjiUGiMfPcb5YWVLtBvE7RZZFPno+Flo0nrvaChdb9vSwaGOZDHrD5LskmRpR/N4ADVy1HDzHVDq/81XYBFlnmsvOpBgb4lXPwnNG1MFCPhdflao0zi8Qp4DDphIpy/4lDLbttD2oJgx8nWfZvK5MK3EGAsr6zYqCOUX02pYukWGP6izCO/dt4kuFOeU6rSMjnl8cx+1BefbkrhHYCRA5XjMJ0z83TMNdVu0aYxGN0QOEbrU14WTpzgxFxFabSkv68GDwhfbzTazXdm0TFfHwR+332IQv+cfoMzNCKc5
 g10tOMKBOQ+WnatqvB197VN2BYdKomwNAa6/X2iLpTeze6oEi2/mai8AE9S0eeDf
 Lm13rkcwSwG5gWIQu3SV1FBl3eEgrA0IT4be5Yeo0u9PF/lLaSznA/i2uYBqZ32z/4ZhbPtNUxR4uoAOWYT4HxVaH3f2N6dgDnWzHxPz4k1uNVRWTbORf26xe20wuChf9oJCymk1cPJRTzvGYKMl5fc5OP+DfOND20SEAEQEAAYkCHwQYAQIACQUCVyohngIbDAAKCRAWQniJpbhz7jtqD/95JUDDPwv001ZkaQq1qdo0IQuScCnEeYy5jWPBg97KXrxpPEQ107cU8FoWAVENhgGtI0bRxOPXf/MP+X/P7v0GkmOSTBsECu27GYGfVq97cpna+Y+QK57c2e/CwGvAc7e6gddfBpJFDj2L3CV9VDecgqyQUHvH1hdD5A3sfkRxz+bYErg4kKp17XLH5BYB/amFMYMZ9zlM2sgHdCnLF2NcbJdRDvj+9HL6WDaQA+JFZt4Nnxse3QX5Hvwka4ASl0K7dqQYPC+V3VijKnR3MPVSqApYOsbvt7n+cSKzL22O0EecRYbOaEAoT509Ux7vZSbV3HXsY+9P+A4a/l3OC2lxfLtxNh0hoI54UPCwy3NRwHcy9I4x3KNE79QpuH1hSfCGonV4lLFc9SW0vehqi0U4TGw61FIHifrWIp/oRQxtSoQYu6tklqOOBPs7k4UAJqVoSdeLkiptsWvoplwQ+/c3Ph8cuxeAO993bIZu1SoMomZ3wFkWIOK0nqwF2iTB1R3GlUb/+BJvYsLBBE9/BQYLWd/w1ZBQkiGvoG/g6sJ8iimhN13tpqXm0Au/LybqAwNItz/fwaqaoq/tl5U1zofRUOascEdd1VeYRCwjxEfpAD/mjVACV4idc6NV1Z6e5GB0aKTJ8toQEStAfhHXom8XBqDvV6HpljHZlsuWGjhFSrkCDQRGradbEAgAhKjUv2PNQACwnhWAFPs
 ARENYQ7ltqXnNHNMQBnjFAK7M2r8UwXhZrVkb/YKw1kr1RskBPvg0P7O+hp/r6SGU
 gUym77Dg87Rk58bxesTZVsBVeHVlWIo6yI3yHId1IMpmGUq/XZm4NI9tj8+NhwFzgL9YQeOYahB2dTk1HdkFtvXEsrISxQ9U6Iyx5ytxlFLWeuguzWWlw2QtUkpyOAfnnmqu+/ETGNmf1TfPOXI70PnAxNvxj9jJwvCISLR0wPbWlepx5ClchVZknCmU0yU7SHvDjLsV8Ft4Xi7+H7ZZNQvNs7kwvLfwuwtivojevRwb6rG/+NYKYE3TpdVwNrHGjwADBQf/YLy84IIFHydHb64NX1kp09rahYn8dsHCxC12ew/YsKnDrMmVmtDotOli5rvVM/r6htSjMcXnduGoFm1ekZG/KZzNJ8Oay9Tdgw1oN94VesenXgzQXLGPIBYRbp++e1XrB+uKq6sRz8PUAAAr3EI4iwCP2ZEqwbK1914NdQo7naUqr9YP277kpiqvjtKHHL8xrO3YgbuTfDPfYFbxyLFkdMahcpwym8r0pzSjrawcv74bO/32W71LQS9cdtk9Rls2Piflalc+Oe8q3wY/MlYUokVGabJ1UMVxOX2Mhl9v+v2/YWdHCBf69iWQKh0RTv2Ku9RH4cblf8Ow92BbpJqqoYhJBBgRAgAJBQJGradbAhsMAAoJEKotwq6l89tW+Z4Ani1uDRazLGEj1IEFFNxz42xmCUJvAJ4h1aAcKVbPskEud7e2ZYI0t7BMAQ==
Organization: SUSE Software Solutions Italy S.r.l.
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-Fuvz2/cFA3H4kB+YCBm0"
User-Agent: Evolution 3.50.4 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: permerror client-ip=2a00:1450:4864:20::632;
 envelope-from=dfaggioli@suse.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--=-Fuvz2/cFA3H4kB+YCBm0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

With QEMU 8.2, guests that:
 - use SeaBIOS
 - use something different than "-cpu host" OR don't use "host-phys-
bits=3Don"
 - have more than 2815 MB of RAM

have problems with their virtio devices and, hence, malfunction in
various ways (e.g., if they're using a virtio disk, they don't find it,
and the VM does not boot).

This broke all of a sudden, as soon as we updated QEMU to 8.2.0 in
openSUSE, and we got some bugreports about it. E.g., this one [1]
includes some logs and info, but I can provide more, if helpful.

I did try master (instead of 8.2, although it was master as of last
week), but the problem was still there.

I've then bisected it to SeaBIOS commit:
96a8d130a8c2e908e357ce62cd713f2cc0b0a2eb ("be less conservative with
the 64bit pci io window"). In fact, falling back to an earlier SeaBIOS
version, before that commit, or even just reverting it [1], solves the
issue.

UEFI guests seem not to be affected in any way, no matter amount of RAM
or CPU model (well, of course, since it's a SeaBIOS commit! :-D What I
mean is that there seems to be nothing in edk2 that induces the same
behavior).

A way of working this around (beside switching to UEFI or to cpu=3Dhost)
is to turn on host-phys-bits, e.g., with '<maxphysaddr
mode=3D"passthrough"/>' in the XML.

It is, however, a bit impractical to have to do this for all the VMs
that one may have... Especially if they're a lot! :-)

I know that there have been issues and discussions (and they were also
related to virtio, I think) about these changes already. I don't know
if it's the same or a related problem but is there a way to avoid
having to ask people to change all their VMs' config?

Thanks and Regards,
Dario

[1] https://bugzilla.suse.com/show_bug.cgi?id=3D1219977
[2] well, I actually reverted a6ed6b701f0a57db0569ab98b0661c12a6ec3ff8
too, for convenience
--=20
Dario Faggioli, Ph.D
http://about.me/dario.faggioli
Virtualization Software Engineer
SUSE Labs, SUSE https://www.suse.com/
-------------------------------------------------------------------
<<This happens because _I_ choose it to happen!>> (Raistlin Majere)

--=-Fuvz2/cFA3H4kB+YCBm0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES5ssOj3Vhr0WPnOLFkJ4iaW4c+4FAmXfox8ACgkQFkJ4iaW4
c+6QIhAApPHN7/ZpeBfmPQTvzBQvyFVPdYXNRyX1fwwA4AMpo3Sy+Wy2QGx/V7Iy
ETVm68JFOkxLsU4Sb4iesoqLNrj/xSwC0Hs92eg90IuJ6NWvx+YHLkdZYJuLadIJ
W0ffiBmhuQw61Cq02vpIceB/Qm4J3sXPfAWyhcW/QFY3iyYiBm0vfc5Ncfo1GXj7
fJWnJXvbSMxGDsM9g0ebxi0Mv2tSyGj9xsoVxwHSNDjXFHwLpoUow+1YsJ15a7XJ
qO5+KjhFwMADylRzjOoUXA1768gjZayx3VGQ5ylQZFOVV/gLwcXHTBkJrKdc6sf6
Qidb16Z0+KXg8VvCn/MAJ+mZyBoYnzQpWUc/r6PUxHXasny/3JTWbD2HHKyrlgtX
87ukT6rreqAPMQ7D0eGsoqZJhzZBA5ODMsOwfa9N3OsLr5UdYqw7/wJijbg97/oK
gnt2xKJdub+TLdKcgWqiJPLcimIJLwgJx9Lk4wE0xZRYLLj7uy1RMGqtBFqdpzQi
/LW7nIY2J/lp9yba1LBxPjkxzP8vTZ0+s3AvGd+WUeqiDqr07oZDC4WlybjazMTi
om8fzPwj2P2aLl23Kn0U1kk1SvBptj1Jwfcou39MbhYnbeWNJKVDkYSQZf63sJo9
U/s3gME+WeroRUH8z0GNDV2tQrvFGFiWKb87ubq32fN4gHrHXow=
=LbkX
-----END PGP SIGNATURE-----

--=-Fuvz2/cFA3H4kB+YCBm0--

