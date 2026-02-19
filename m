Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17342E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 13:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt4Gi-0003FK-Fz; Thu, 19 Feb 2026 08:40:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vt4Ga-0003EW-Mp
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 08:40:28 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vt4GX-00083y-KY
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 08:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771508423; x=1772113223; i=lukasstraub2@web.de;
 bh=sKAXH2KCWonuRRpQ6HPEwMGr71NooAvL1mjKvot5ePg=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=lkIPKpTH8vBySY6YMSIJL5uMf+Kp09hHbD0gW15WcjCubM3cujma9jYRTTXdepN1
 klct6102OlWyyhAOGtD3UH874xLMC7nZKn1Qjsqz1pWTkzSHTIaJL5H3lQ4tEA4dQ
 6XljaRH/I5GyS0hX6P7848XuUuQauZxAqDeDusqOiWGbajhIj9zB/6GMvQxqTB8n+
 TYbmEewkuc/mazF9Kd9S+jXBFCKXiMr7mlp8ud4W69Mnw0vXWI3Igyrns2gA0O7//
 xjLKVejwWs6xD5iaeEzfSf0uFEhJ2mncZgWgu665H+zH9ykOF/zJKwPu19NrF4dHM
 cVdLWElQlfQ/eeVizw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from penguin ([84.133.37.84]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjPUE-1vUUtY42mY-00lssR; Thu, 19
 Feb 2026 14:40:23 +0100
Date: Thu, 19 Feb 2026 14:40:20 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>, Hailiang Zhang <zhanghailiang@xfusion.com>, Markus
 Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, "Dr.
 David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v8 00/17] migration: Add COLO multifd support and COLO
 migration unit test
Message-ID: <20260219143627.58d34935@penguin>
In-Reply-To: <87bjhnmp90.fsf@suse.de>
References: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
 <87ecmjmsbm.fsf@suse.de> <87bjhnmp90.fsf@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5wVGSkd36B9yFOHb5S7Lc4M";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:o9qsdz/pRSJIcwZEb1dg3fohYbEUQNlsJBPplEuyaQ1mSgjMR7e
 fhqJ2Agzqnb4GwCsWhm0BoJcrNklkYy0QBkFjP2Fqf+IQ0kRvf6y9DJn54OeNvID49Ar2Yj
 vPit8UuyxygZsEOM8a1aUKGUpQ+txmLLyNFk5uVS2cl193zgli9og/itHvFmUsk6cMT5RnZ
 Op8E9t0Lybipw4xPS6QfQ==
UI-OutboundReport: notjunk:1;M01:P0:KieobHiowWI=;1s1YRmxTRRgJNyu67EuZBcT/ygl
 z/tLNHyY8Fw18zhKt29svPyd7fBjsurt+jobtNH5Lj1ZC1ulLFpYf7Tgu2M3ZJ1xbSRqi5Et3
 6EaxxGu1owBK6lJDqo2uJ0TGK1OnR1XrO9WYGw6whHIWLG0+lHM0TjiE9nUXCwoNsqHMA3WHn
 Nz1uwfxD9kHPjqJqSn6iM7gZXCiNRhvYtLQ8b1qgQl+MCT637EGaatGs6UvbdVAMZ7AlxshUH
 9PLgNR0tUheHAMgMi3c0G+MEpAeV9N6Jc+lIXA8WlCt4DZWzhcIJDr+LAE6BT0QBfGp0Ud6x1
 u50/LrkPNTLcDDxcbQS1PHSg3Gz6qsCDMerJ+jXALsl50sI44gb+yoseWaVVVXy8kGCXeyWCS
 Dh5NGulxSzWf16y+uC3kgwfr0GvFYQ8mfA2gXg6BrkS+oNLueOEq9KwkDN2VveLdAa6qXN2yE
 y8H8QdcZWXm2+e6VmgkGq+gOPGy3/Eqph6iwsgPCqw/dWJ/CP32+dy+5MqbInDh1qgBO1ekJY
 W2HUa7CdZI8UZQ1jEcD33dKKfDiDKHmU0TINB7YA5ndwyFoCJ8+EiQZ1/755Y9yBYG1eS0ylx
 EseYC0mbz+Ck8CsNcPQr89c2ddDSrpVNb3nZ1xcZHQmvv1PWeXxW3h4zRAS1xE618X1voaP9N
 Po+LFtAboC3ykAnII8h8OoJzImiCYfEk20tkXkrmpTeFLegtxvzA0G0T3AL+lmhD/VzAMGZRN
 ljunEevrJOx6Zurp9myIcC2SzQFXHAe/TIKnvK0ffGTaXaFCzAgFrYy4z/eHLaej3lQPXJfuT
 +jPCyOMdf2fo03QjL3j1+WCKWsPZO+7zmsLrgznBCB6hYwvPVdxM2jbQJZFW2FHprpPhkMinw
 TACiEb5um2faB6Gsradq3B+nSTFkJ9KW5mDmjQa++ZLRbA8XqitVCC/Xw7p/YkkKRIJCL0G25
 nOAvmfi0/1yy473FXYEzgtJ4dfbvZSCSlgNhmnuz3+iUmmlDrEuUwn0/aKh0CzdDkPHmb9vWT
 +bXzRllkMFpFKhAnsoiZUpUzPlzA+nUbW1GUahfyhUl2VGfXWqS2Q8SwWDVZ0an6cUoZ/Q1PI
 xZpxoqbsHj+uaj/00C5MHtn0Wgz2TTGqUL8hjKEeaU/tCWwP653TMNdPIA/Wc4kL3CZ3ekEQg
 AQoPenttk8UR0I03Xu6TCK6RJvv/ly+rx30lhsPBnsyQQEuGrVA3ECUOeFSEbu8MtuAxT/0Do
 ign+pfJ1GY/u509hE4p3Y3i2y4HRZV74J3CzHvxCSFoFvAUSbUdldL2McNB8kchOXYw70f5oa
 +bsq/in9cO8UHMyliY/g5osKfUQkKDmZkFMkPvbc+ry5GDYC98sc4PzNc1pTG4mBv8D8ZtvFS
 ck7mTTN+Jdb0cjiglfsFPr+TlpDpFHDwMFRhGKexUj8nXZ2sOkssjkolCt0caRSwMeWoZ/oof
 nU2oCQZFHeae0cSEr8zwMQ3+QEDNo3V15fUwymT2EGnHA9V7d0Av9oM8hDcBUUlSDpvXHf/G4
 0VApKTHVZUEpSifodYKX3kAg+tycd9wUC9Q6et3X2sjlHFhU/CNyUUqDO+q5g1PGZFqPMOfEX
 9cE2AE3akawrCvjql2rMxkyiTGlGymQuo2XhbR4pzNOg26SBg/IrKVqX6gklkqTpxqOnEFvXA
 l2SDHbtukmzKglc3ZqiZNAbXUkZ5iQ2ecrYdlE4eHs4IA+cdWhbOln9pjBRIf7SwlXic+ctvi
 GRkBRzjwmfhrsFz96dRKpMrWSCQgs7ccPpapAM1wN19DsSW7UkrKIUFNiLDSCRIrZ9Xf0h184
 48KORs4YQ7As6ZSG/1bp81GUxXUi3ljwPyTD6cv57zUMD4IIbBG/+skAXdsEvfXivE+LAZffD
 ucMxtcTmdPq6vd7TKhP+UWU2Qt8it3FfqqmTPEA1wE1LQCbAQqB/CIpWCa9sg4jrKAzdg6cFo
 cZ39ezVO024GiUNFHFAXmcZkdZpPH4SDoJFlfcnujItwIQHw2dCvuExNQf/TlDPibCOvJvOij
 HdRxZUJrjaStvnhcn8bgCgvafQ0iP5+0chGdTfRsLmXUtWrrLyr4yzBvCDSr9oS8t0HarFkib
 czavQJ8dgR48xPHQZIZpPkSZ7UMgCbu9fQEVpUOpS5+Z56hPw7UDr6BlujkiIJUtQknD2sfPF
 QO1RtZTA0j6tYO+o6n6/Y5VuQp5NaqEAcKIdryf6TXEzkaOGDWQWunUFRPbb8fX9Bospt5mQ3
 s8PO0AwbAlHlZI4K+xRhmVDfBC6VyLMtgZ8UPxMoKkQI2MmGreaB9j54fHkFvTZVUXSfLRRo2
 UvSe2sfWmeEnrR8rE9sLBQU++abNoE+OBUebCNb2OZrM19ixPY4S6VMK+Ba2+V3JwbLgh1ge+
 XfPKHvirKlO/4z4kOHjbdQCvf1yQIR8OnXKjg4Ugs1cCeAftd+67SOIiEby6Qjmjj1WzGBNcp
 +2v2CaF3T8KjqlyK/vn5fA0rGFi3uL0q7S0tx9Uc+A+DcnLrw4x8sCx7vcLDrjBe0VYWKVZFS
 uk3Gz4D44pPKFJUbqDe7Fkw0e8gU1AHYOYGZIhCEfi9Zr/pisFvzsXOPO2G0trlcl8ir/mxiF
 KSB50MlT9yopYPk7HpaV/1uqSF6UV/IL8c9H42EVslpzYuzZFsxrd8beMBSvUbzo+m2KW03pf
 kcE6Fk9v5qywym+0O7kfTVfz26u4H+SpFK458glzegk37iUcE7XOAAPaoWR1mbISLmOvJenN3
 sr7pIJyqEPEDzJz4oO9ua8vNG5VbhdkkCNP+bB8iQo4YpMbhzmBRbG6CuRTBVXtKrsl+MVldy
 r4GemOzqg0NGxOuRcqcOCOv8f6r51mukTiY8TutPW0+ZKMgFAatsCfaOGTZ5AbNQoWPr7KT7M
 in3I+BUDgJET9Dd+IRhL2bciryHNbMhTX0kRyxccXj2DKHqRMoKS+VrYD0RrOIiCEhBE2Rauc
 EZ7q9ZtJAbMDwY/iF8RWx1u2BtW78QVdAIjjZih5Mk/vSt5/cu96tDorikPSIPwL2V8pX86oT
 KSgy/cY78GLsFklHd56e6fkTCKm77ITtn/F61RYk6m7TngzlUHMYHsiZK4YM9uuLK1+zek0KD
 p63PXarm+sOLgYUD9UalcuwMkcZCiuJ9u88QIl1sT/yFMSt5r53ll42aR1aQEkpVF6yzKUcWi
 GNvzJ4wkRwuy4N1B35EchxJarmRofuCt9zjY0pwofYoJLAhkbSJCoH/9926TKp+XwQ6NMrvEY
 RNpQwscbyLAps1M1Uco0bMpIKhNj8Ql75t/fWyf4NPFxLSkEh9CqWtemYMSYOEHsjy0JFAm6F
 VYWMbpKfCKc4Qkpp7kDfjaHkjtMOXHYdNTMSGB3jkcEPpdxsCcF/omIR1FWH8r3/WPSMEaVgS
 qoFKxK88UHiAo6VE405hhw6a+9QQqz+Fnh3QzeaksDFYtqJxjZuD+ycRoVrdHA2+w7uVP2jc1
 lXGa7Qj503MuaKxk67NFykdYOVMsTgfq4BijTzAAtI65g/4uOKVUMKgAPdUDB+jlffoB9zabf
 LBa/wePGR+Y61OKEh6pA/Ho4zOSwDpUOzHbT1olGYdaA9YiWBlgZNWDzS/s1Ik6VU4x+2aXRy
 TLhjAZwkqh4CPAxx+H42LzXjvskoKWWzSfnlk3Nt2EOKtA3VhIMyPoBtSEvcWN6xqFpWvUZie
 HErczYo/dL/05ZNPYoLTYhqBHYPLNkfiDUknNx9ixs2DIe0GbWQyAYq7rMV57fi5K/n6lG2TO
 mbBhLmuPH5dzDT8ijwW+ZXY/jPmtcqtPT2cEL8Mmc/iUPNRnwBTYSZuxok12TRy83Fa5R5UlF
 FXCyCWhGr4IASzWVVySQdRk41QiHDcRZ65Lo7SR6pKQrzMxm1PlAoVvCZZMJZ1IRJG9qAJapM
 OWn6DPtFw1fjqTC+kT55lfcd7zfgm1HGyA3W32/ceAY/5QyaU3GUWd8kHIRWDYJ2cxciSxtg8
 tAhLqk5bRfRjGtoIObu2c8Cb/PR3lNICD+KFxq9F3HrfgZKOqghSuh9V1unPTCQKdeH6OgkPl
 QWB9aoRYCN3YBVcpx0e+6WkRTKJ7LVNB9YqR+CSg0QKth0hcF963inCu9XrJCmz1MJeEdb3aR
 7tq7GAsc+OT/GnBbgoiGhqleHdwlutAMQqKxLV2JYScwTly5D5PxjJOuCqz2JUxA512ZOZkmU
 jp3OXhdY/huCZUAKk0egv2HAOnpJufCCDZyPUyC0ox7UaPVYUBvr4lj5a2kjLVd/LBxD0moSH
 duFsP3zlnj/UynaJabPi6Fe54fSJg8CHRefqtyq7ihnnTJ2gr5nbSl9usjvB/TCnfTwjdqnkZ
 +NBxtXVag00Z6McJFk6FPSvje0Q8O1Ri9UelFO0ROwsHwLCWsZOHGHi55GWYje8NkgBvQUfnA
 y185BTk3Iy0rxjDq7DA+4P5vXShQDWdF86oUAl5LJy5YvhI5a6bXfx9TqTTSe2xAzUuoOvOey
 o77GzNu0C+kUo5XN0XMA0tLWvYAcRGdNfQgdRIpGU+rgsGlJSv7ZIB04APO5gOgQfJhFhbbLS
 4c/adqTKEl13p2RFvMbInm8Djv/rv9GQE4SqnUN3eHZBimVvZHvdkGnqXy0Sdfy/llESnroJ7
 FacNbZ8o9n6pS6H7+PGbZS1voYjApHzt4JAdSgt4IJtHrSDL+pEima/e8k6iG0upKI1qiFYQh
 S0NAppnb7am5qegDfLaNSIOPpT44reIbiTnrtngvCbSy5MyODiZT7Iv+8THiWeh7Q+8Us6kT8
 2+zvOunvN8FWlKpkr7p+wSKYDna5/8lgl00K+Xb/fMu3Edf09e4SGthSKMNsC2D6xYPomLwnN
 bNXcbsbS/aS9LXBijXZYxinbHAt39HkFiiEtmkKahZD2mAtBuTHggwjxrk257svVyjmBeCb5d
 0/xXeI3PT0sS9MMgc0xJH3Czs1DGR4s4cLWjeZ1iwB+yivIeZXInpMBu4KrqA7RdF0D2UBqqG
 rckcGNibBeaJV6UTEb934zG/hYutoHUnAELchEAZEOsv5sgt8zDgt958R7/SEa/apqxSsbbP2
 dc9fKZNt6RgrTaUZci5gAvpMzMlNYOdfjq+4e2jchdXgyZNtoVt0j8na+JGhrmZoImJAomClK
 G0pjUWv9kp80jaWvJBgg48svOmqW4rbLPQP+cZIJtt4vBxt3TzI0UwHKbdq/5p9HjXDtu91GN
 tVuS9axGsAC4qRGpPSShYIOSYK51FlQgEKwbiqSPr+gfij+F26upOqHAo4+wZ7Wpv3gNR4l0B
 nUY0sc37aXz08GWYDC2PJmT1Vau2Box8vai4AVTYrQ==
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--Sig_/5wVGSkd36B9yFOHb5S7Lc4M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Feb 2026 11:14:03 -0300
Fabiano Rosas <farosas@suse.de> wrote:

> Fabiano Rosas <farosas@suse.de> writes:
>=20
> > Lukas Straub <lukasstraub2@web.de> writes:
> > =20
> >> Hello everyone,
> >> This has some cleanups for and adds multifd support and migration unit=
 tests
> >> for COLO migration.
> >>
> >> Regards,
> >> Lukas
> >>
> >> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> >> ---
> >> Changes in v8:
> >> - Fix peter's review comments
> >> - Link to v7: https://lore.kernel.org/qemu-devel/20260210-colo_unit_te=
st_multifd-v7-0-23bd32f36828@web.de
> >>
> >> Changes in v7:
> >> - Fix peter's review comments
> >> - Link to v6: https://lore.kernel.org/qemu-devel/20260206-colo_unit_te=
st_multifd-v6-0-27779dda139d@web.de
> >>
> >> Changes in v6:
> >> - Fix the crash when running COLO with TCG accel.
> >> - Link to v5: https://lore.kernel.org/qemu-devel/20260203-colo_unit_te=
st_multifd-v5-0-57508b7389f6@web.de
> >>
> >> Changes in v5:
> >> - Remove unused inmports from multifd-colo.c
> >> - Mention the checkpoint overhead of reset to the Q35 fix
> >> - Link to v4: https://lore.kernel.org/qemu-devel/20260130-colo_unit_te=
st_multifd-v4-0-7115ab6f0e77@web.de
> >>
> >> Changes in v4:
> >> - Add cleanup patches to remove migration_incoming_colo_enabled() and =
MIG_CMD_ENABLE_COLO
> >> - Add more comments to the colo unit test
> >> - Call colo_release_ram_cache() after multifd threads terminate
> >> - Link to v3: https://lore.kernel.org/qemu-devel/20260125-colo_unit_te=
st_multifd-v3-0-ae926ccd8eae@web.de
> >>
> >> Changes in v3:
> >> - Fix peter's review comments.
> >> - Fix COLO with Q35 machine
> >> - Link to v2: https://lore.kernel.org/qemu-devel/20260117-colo_unit_te=
st_multifd-v2-0-ab521777fa51@web.de
> >>
> >> Changes in v2:
> >> - Fix review comments
> >> - Hide stderr in colo migration test since the logged errors are expec=
ted
> >> - Add benchmarking data for multifd
> >> - Add myself as maintainer for COLO migration framework
> >> - Link to v1: https://lore.kernel.org/qemu-devel/20251230-colo_unit_te=
st_multifd-v1-0-f9734bc74c71@web.de
> >>
> >> ---
> >> Lukas Straub (17):
> >>       MAINTAINERS: Add myself as maintainer for COLO migration framewo=
rk
> >>       MAINTAINERS: Remove Hailiang Zhang from COLO migration framework
> >>       colo: Setup ram cache in normal migration path
> >>       colo: Replace migration_incoming_colo_enabled() with migrate_col=
o()
> >>       colo: Remove ENABLE_COLO savevm command and mark it as deprecated
> >>       ram: Remove colo special-casing
> >>       multifd: Move ram state receive into multifd_ram_state_recv()
> >>       multifd: Add COLO support
> >>       Call colo_release_ram_cache() after multifd threads terminate
> >>       colo: Fix crash during device vmstate load
> >>       colo: Hold the BQL while sending ram state
> >>       colo: Do not hold the BQL while receiving ram state.
> >>       migration-test: Add COLO migration unit test
> >>       Convert colo main documentation to restructuredText
> >>       qemu-colo.rst: Miscellaneous changes
> >>       qemu-colo.rst: Add my copyright
> >>       qemu-colo.rst: Simplify the block replication setup
> >>
> >>  MAINTAINERS                        |   6 +-
> >>  docs/COLO-FT.txt                   | 334 ----------------------------=
------
> >>  docs/system/index.rst              |   1 +
> >>  docs/system/qemu-colo.rst          | 362 ++++++++++++++++++++++++++++=
+++++++++
> >>  include/migration/colo.h           |   3 -
> >>  migration/colo.c                   |  21 ++-
> >>  migration/meson.build              |   2 +-
> >>  migration/migration.c              |  61 ++-----
> >>  migration/multifd-colo.c           |  44 +++++
> >>  migration/multifd-colo.h           |  26 +++
> >>  migration/multifd-nocomp.c         |  10 +-
> >>  migration/multifd.c                |  19 +-
> >>  migration/multifd.h                |   5 +-
> >>  migration/ram.c                    |  12 +-
> >>  migration/savevm.c                 |  37 +---
> >>  migration/savevm.h                 |   1 -
> >>  migration/trace-events             |   1 -
> >>  tests/qtest/meson.build            |   7 +-
> >>  tests/qtest/migration-test.c       |   1 +
> >>  tests/qtest/migration/colo-tests.c | 198 ++++++++++++++++++++
> >>  tests/qtest/migration/framework.h  |   5 +
> >>  21 files changed, 720 insertions(+), 436 deletions(-)
> >> ---
> >> base-commit: 0b91040d23dc8820724a60c811223b777f3bc6b7
> >> change-id: 20251230-colo_unit_test_multifd-8bf58dcebd46
> >>
> >> Best regards, =20
> >
> > Queued, thanks =20
>=20
> Actually, I'm gonna drop it for now. Tests are failing
> non-deterministically, seems like a cleanup race due to yank.
>=20
> QTEST_QEMU_BINARY=3D./qemu-system-x86_64 ./tests/qtest/migration-test
> --full -p /x86_64/migration/colo/multifd/primary_failover_checkpoint
> ...
> ../tests/qtest/libqtest.c:201: kill_qemu() tried to terminate QEMU
> process but encountered exit status 1 (expected 0)
>=20
>=20
>=20

Is that with ASAN? I never hit exit status 1 and looking at the code I
don't think it can actually exit with status 1 when exiting with
SIGTERM.

Anyway, I fixed the bugs I found during my stress test in the new
series.

Regards,
Lukas Straub

--Sig_/5wVGSkd36B9yFOHb5S7Lc4M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmmXEsQACgkQNasLKJxd
sljaUQ//QXVgjs5D1KC8mr2ZP/LXS6zqKs4yvPd7/a6Ku9BB7Wj+J1GO+5H1ttuj
YsG1dKBXOobGcPJ5AsAKSLzoqyregUKdQxPNOLRT4F/WVZd3iOt36NqcS5G2AIJA
lSY2CRd/hkAbDViGGiiRwV9W/0k5+6zgf4Xx8zW12hJcewgt+IxmDNAlIutAEDNE
r+1BiIK1x/EyBFiEazgVaXQA6UiRoUoUiPHTteczHh7/tqnLIGPenUuF0DdC4wK8
yD6/rNWvC4ocMyY9Yk/4yzLjSf5xmuaNkJp1m3m682kgG/uRCThrAANmG5DYmWtD
mOYnQaE8Fl5vxVWw2CLjUn1NyeORVvPS67crk78RzT/BMkGYhp8UoojJAaMQXfHY
/UwsOHE+H2U0aHTL2xQQ8OwYSvDeOcEmEb+5ZhqD9EWqqXcLlvxQuNVvooeIbVcF
yr4lZY1+10WbQ413rBxUTAwO3SZ2yJhBBhseAJUacZJqvc4dlD4800LYt/GsgzME
kHaw3bkcV6X7ErdiS2W4f/4CB9Z5dkQu61eFBZaF3w+2AsOZYHZrYvedPNFw7Rl8
oNse9seAv6Jawl1NHGq0TmINqCBa4mnMi8xh0sSMRTiZSQl3sb9uX/cB5l6qCdQW
Z0PwPjzc110nllefK5m48cf9ztI0mymuWiDF85PFAdFTJx2B5Tc=
=gEpZ
-----END PGP SIGNATURE-----

--Sig_/5wVGSkd36B9yFOHb5S7Lc4M--

