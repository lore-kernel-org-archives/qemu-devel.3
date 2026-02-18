Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB9BE9A049
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 21:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsp7T-0007Bn-Hw; Wed, 18 Feb 2026 16:30:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7L-000796-QN
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:56 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7G-0007NM-Gn
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771450182; x=1772054982; i=lukasstraub2@web.de;
 bh=5DRNtylFaST6/JPH9QU2U4TO4NvWnISJBshbkAaedFI=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Hup+Gy0r+3rMZs/Ej195CeCNITMWSdi/v32LOS4JOQexetYkw1DkuvJgNMx/ydHX
 sveV++aNvqjKUFxe4149k4gCktaHCXPBEZjb8+RihiPkwewZFx+2yMi587uXJHDl5
 zKlpbSYHjvVYP/uZiq6pBGhWnpOz/65spTdLYZLAtq0fpKOEF5neJcjmHYwOOpVzj
 8EIESNH62f2AmRKX4a4p9/7mTLvZNijkutbjWY2dswD2dyn4VJImilVg3CRbkePsR
 yQCD4YWC34wT7eKsDPPZVnVrQ9ST9/eKiWREudjM8mRqE7Wq74c5EYVMNCLtyAJFO
 pIxKPi7VSQiYhVicYQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MlsON-1vSFbZ2L9n-00lOTw; Wed, 18
 Feb 2026 22:29:42 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Wed, 18 Feb 2026 22:29:37 +0100
Subject: [PATCH v9 17/19] qemu-colo.rst: Simplify the block replication setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260218-colo_unit_test_multifd-v9-17-d8dbdb0ca6f6@web.de>
References: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
In-Reply-To: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4393; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=TYU6TTLFHjrH9WpcMw6oVhFbPAVy0WPrt4oU9i8UKQI=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpli89ZFJ7XgtlfxuDJPjT2KcsIX/auvHyhPsM7
 KrNXbg+9lCJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZYvPQAKCRA1qwsonF2y
 WD6iD/9PaKhloaEc62rifLMdr2w0j6S1B6tbXdr95/LsvCdxZjbBFg5WJJjbEX2lcyv81JtSOHJ
 joCfVNK+cngFHvrNPFltwOBtL+ZTU8N35cXoK1ZoQdp+cYALOOIo9r9LBBzEoqrvzVybNHwhhJC
 1RIir1ur6GYrbANPM+iHyABW4jUC7zTX3SBkn2sZu2DM4KrD8H2+KprhVgy0cMtRJi8jc1n7P29
 rKUtBWEHu5gXlEDMFN/dn5ZY+bkScrWPRo/ZUOrvKiuO4A+O0KNUHszv6nJBeqlHw+CZqLjZbuS
 D1S1rSrhn2rb+U30RBZNCiBqZLLAagWYHqpWAwVVPExy1LxWiplsUlCRBqwKwinBoceHm6lSHbC
 YOr7ICzWcI4vMX4FvuH5JGhrKSH0Kml9lqanlmnB1I4P70SUVLum1iwlWFuiEjOkamNmxhuq0+8
 LDDW+EmwktICOaPuvP2zCvXqei+y+/lRtpsNVRGnO2WrF/hz/gvixDTIiGqICP9+QPKoBq1yYbq
 7uTsqSygrrxIm9f2bk8RSY9qHRMoRYpose7vLTdUzwoSPiuU3hYI+tf+s5YtfMWgEiMlvx6kGVQ
 qC3SuUtiQV8Jusc72jUYVD0xg/tmeidCCrNf8NGc8PCPsMMg/a0JMNLrNlyN12WaUEZQrCvAb5c
 wSXiEiipR98rj2A==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:0xNRNpF5gZOb+eKXv0oyOZcm6tqrMa7T773HNdJmGQL2rY0Vm/a
 q3C6sugqaQ+EInJH40zgMGK3kVFUcQsokXKHaG274iD0BtsX+by8d1hpW2rKnZmL/N1hwkh
 vwzEIVTt24l0a9y7HX7f03ooqnXw7yZNCvdts0AzYAOalFIIUy4bOXQKyb64Asl147OYETI
 6CGMbCS7JfvkmP87G8ZRw==
UI-OutboundReport: notjunk:1;M01:P0:+YJc7BaInmg=;P8yH+R94lvmOlcrpCPUkcG1nq+g
 ul70/DTKIhxyPVCI/5Aqsm4SJZSmMQ6oAauwxb2hjhvEFwJx1aeehMAVkR1Z1C+LFsO3KaDdJ
 5yYrXNeTkkZUfeQ7uqHzOinvinFagW9Qeqr8jSCyMqors74J9ewaCxXq3SsZcXTZr0j6wJMwZ
 CYJVSuJ4CQfdCErYcoKX+e6TDe3sX1TpL+tuU5D8midPbIEFtEz4w8xI5Wpn04oMdTP3g2Nwh
 uj0oNk2IW7Gh0+Zn0+cxBM4g9VdNUyOpuN2m6xFBZByhNJZ1+phSu3kMUFBjrYgemWQmS2onQ
 hq5kw1XNk5LiQT2lfRBVpJwpmIFlJ7Vu3uWY5udpNiSIOqSRNmJOLOhNpRpVC4WZe7LvTA2PH
 L1lvRilzk5NcButa4UdKMrgaF+7wgUruNJCmu7EFnLfJuxhJ113QIKXMtJox7Rpk0Lk/zkrhI
 acxiiQTjarM0b/KWLClqevY+n5oMIyjREw++m91arom5swamVWADejzYp3HvSe1QdZcJk2z4M
 ylnNAkR8Zmxc0XPvpQcq0ykM3pOmBLVQJGivS4f/issy59uslg2keKHPoziKjhzQb9AzFuIcl
 Znk4IoVecuINw5XDcWrP+vStxHjBd8g8pFwI7nbE4OEE0BR5ZH0rQdN5tkiT/tDWLZaWKrloL
 iM47admKi4U5zv3RMmoOvbCPB66uAN837BJmgj/c1M+jUvZln/LlxJJgFTxp41pKBGg6AmyKD
 YfnoahrvkTadMqFDLcXC3f3cemaLwgfo5LpPQRjsHBJlv5B5lBlH6xTtBQYH3AeSg0Br0K/l1
 MA/IMQ1RX+JlNKQ/Blzrx5cirG8Gq7l8ujXbWNAtHLKZxVXtFM8UA7q0EGrM6JtapIUy2Lqtf
 0f7Nc04n/NwWppPGwCQAH3pMgtRIjh1X5FdYMayBak20WiC88K3Oz5oNbOMZr0AknMcTmTGn9
 a13DzhD1im4gGt9eqprBBXhy8OdCx3rLOjItvouW8/e15gCWrKx7YGQsiBkLIksphMxJBJ5uc
 G6+elzX/bBAf196DJkgqrDSmRGuMS5JPLQNMQ39yy6064M4huJ2NRmwbAKOwJXaDfCeZND/J5
 upVubeY0brpnycD2dbKEVQfLOraWNRwXuhD4S/xTekbCZE1HDq9RnAWxNSrj8UAVHHumHkFvf
 Vfc3OhLkRq+9liTAutjXvXolO1XvOCnk8JLSlfkc/8TtXkCfKhYoTYPL9IzL6sOjWn+WIkJsy
 Cj0YNRI4UkMz25o88DzJnJBJpcegi/sS6l/wPVBvqs0sXvmxFKaK7pT2u7TlZvitTKxqH+ztR
 36DDY9iU8jmlGRakDBqE7xzUAKPTyP4leIDMD39gp3pqlQqR67ZDNvOpIldOs+AxC4IkP7nzs
 Ek3Rm40JZ1k6p3fqNSSN+KqbtxVF1105wRBogI9/Jw0O8QYGMvpjlsb4ExJyHT1SYdhgNS9SA
 F9ymf8G8jBajUJ+8UP6YIyulJ+6XIsgXKaCqJUVhRzpM10HmoisuKfCAbPmyvGk8TkKeFS5bP
 GFVbQ8Wbj9xouoMuvvB8ryK59pUzXDEpAdjb/7mDJbJ4Mu5PgWA5RyC2qpsCniIzb3zDixAyk
 VrAEy+O5x195gZPMrFtC42i1JIP/jaeebeoR0qoj3Dbcj1dmLc7wE3Ze6T7QprWWpsyKbuTsr
 fmfBn02i7TDkskyfhKw5GRD5cBYj4MKu76hkM4Twp17EN6Ek01gx1FO5g+jBgBK+E8JIy5deJ
 69Dt6HLDKq29JwpDHPemOIzE25b8siYWcVICCKVR6OwXRUqy0lnhmNvuR8+a02vcD9cZJlVpI
 AIL8nJkETXnRnJrerjXcQaJLj1LEQF1v3Q+i5cw240rJzJhYKvuf9hkOH24ERa84Bq4s5S3eW
 rNCXoYemX4Llai4400m1/JyfCuQRmZj4fG+mSOSoZSLFDGpmkRoGtVRzPi3C1SasKpZDJjnQY
 lVDmcyHOhME3k+ezX4xGWuktA+onZlyuZEc94Lxg6Mfg26kTRToC6+d//jITDb6vWBFN3A3P0
 F8ahGxlHFiyOz+kzmQEwoEo71sSteNF67BCBkEV0H3nIPjjlrNf69GCK6n+id/iid3Qu+z1eX
 pO9/inm03GJzcVGBSKWdmMsJM8KNv9iifWTMPbQ3rGvIxum304VsqIv8QqrjgsSw2Gbc3qlb1
 g8EAyoa0/D4HhDuVnKLzkWO99oPvQO95ygZJoIrQ9oND9qzri43fhzrAbxqdFmf1p+1vbUxbM
 MpzJizHhpTI0ON6nP5vHbu4ukVKajUe7Bh68gW2nT0rmYy0eLSMwho39YZWxs+ue4Rfg8R9oB
 3yDvbgJbgyGHoNmCTajH5FREjR6rXL3O//gSJOADNbiBpXJyFbxq0rqCGWd+AbwIlx8mrEhPt
 EqHGtCAi4cx3TOgOgwCAwEySLYQ5vNiWPPmCec1rcgdJ7ARgtAHHEwsO79+ZYBlmKjWCrcaqK
 z+kC99qqbss40J0XQihNz+2Fi0QpjqG3oEU7Km7IAlpqs2RI6fQdaoEvkhIjL5hCl4eHP/+zZ
 N6aXWGRona0ZlmB5ovK4/nI7HSRNpu+ANUNkkP6oTt0FwxRU2AK8PheX5SSChfPSTxGVrNEO9
 gu9EjIDP+hU0BhyBH3UM3wlXpdfsCvAX6i02K3e638KUeK8fg4M9ZOmwuqokDm7sNTEGzcjKr
 G01/tCMoAvEZBFmrVYsZ6AgoWCi84TaYkk4gC8+49KE3kYog/VTAZHwLIpHnRXP4JVQIW4lCZ
 D36gE7aHeukc3QREuY5rAqowV5GyTzUT9jBInlhiqVPE2380HOeWTSS2O1yKbOxlMOPJnT1no
 W1pdxXMQSZTomh3NeTVOU5ZcS6p0W6tb2KJzs3ZKntYal8k4EIljOjyiw8sDugHcXuFXEdLs1
 QwGWZZ9fTOFOEJX1B2faScOTBuaNpluLldbrLevqsreDMNfq9V18gpg5w6W3f/JNUPfvmtpFq
 lr+xXxogJBPog/BUAQFkW4Gbq3fof7TlHFSNumTwkruGX16Ib652hs2vAIaZav0VINrYe8GQS
 kF51i1uxklcwe7d5eGNmYcHfNptUGGc6IJq3iVOR1v9oWzyIm6VHnFgmFyA8NcCXpie/3hNNv
 kdEiEuzhrWj7Jev9aV1GnMoCoctQmdxuLfHIUf2OXs1kvithljOJoQL1fy1KWHr+MBySAHnTC
 4ag6iSiUx8uxtWmmMlgppBpZ/bbmiaNxbW768DNAfQ+21TItHYypTs8LBxAqKdjaYqzaLzv8n
 F1o2UlCtOtVjRD7uUgRVdxOQ1CXm9B2cpO2exOWUEYltlft+rRDykI7ubUelEdNm6YJeNxo/h
 9LuU/ekhDjLktvdCLnzF/YVLq6aDJv4LAJp4zXDmfXqzKF9aZNSpHvx7OmThiD43U1emW7lPf
 UeY55iEJwHYayZzKebEPj6l8/P4HiJ69+6OzOR18P/SE4a1aAvC5jyTJo32zOlTgeDf52cqE2
 3lhaoHa8Mg5c7TDhpFQDMqEoquSoZenBlfYUptOA7+qFGcJEaOIY4vmfI84XL3S8UMuRIOuFE
 5jzoc3jP1WysD9fAe8NXNNZHyPTXezXNCx1LHtlEmRonXMD+e9EUXjtCAXQEWFPKd4ouzBZ8A
 YrAgm8qNkZYyIvOdGOyrsdBx7eiKUGMNYkMQTojdaQvHxxL+JALR2ucWLNmMlz4mrzcX3gU8K
 gxEdi4kXIlXYtUjbn0oLefZSUMziw9PRVC7Fb/M2fl59kOJg8AjWaHlaBkOvrEiHzAyJhUNi0
 R5usU2aWg4MtUmLCzozf2/6HTmFqVJvkBb5K/Pxgq3S3kxS6u/uzGBI0JlGAvVoI+5UJ+fFah
 6NYNj4UG5YsHJi/tezBNc/C54V9QbByIocegy9L23xlMHLEDrRnaV7ejtkimurWpy0kvvnYzi
 uJz0yP1/QQN/gVgfsQVMkRigDC498hf0vCcCyMDcLVgxat/fZwL/vozpYu449DHS3U0FeNiPp
 DWpxdtA3bPMz7GRdq94jnOGlI+VRU6TX7bWRhLO8fgBP3GJyygPyHMfEky2OV3OrzOr9o68FU
 2zQFI5cyqX3sGTi84dU+jLbqIlAV6ctiPh5DtL46RFBH41v+ljIx86wO/GIpuyDieI/6gfVg/
 1EwUmnlG+Ra6v3YU9TsgpV+Sz7lamWjsyreOaklK1Ij3Ra4tNRDnH8c5PgbTTUrZGfDoVQYgo
 qU+v92wn6qHa7lyj1PMYAA5exmT6GsWFh+0ugtOseOrkFBX2C8Fw+LSO9VIvqQGTTaG+J+hdO
 mYcrWMNXI0nco7xcccnu3G5zLewP5NyULEIEF3LxfJ/uNcUiZvcXmp5Vy3o3CzrejlreTRWZM
 Aqgxm8r/DPDPwzVZmvjzZw6I/++N+EhtZU1jLuSkhQtiJWwhm7ExaPgMm+OMc4pLJKGyxP9qH
 AiJtubhz2hEx91BRSHZB79AO1OubNPxpuxxqERtD5sXhotKIDd1/vKWiCUtAU36hvFvdc2mi3
 VHckeC2WGauzd5y2COelBZFAUF0jpWcpqiHXmIpiWEzeSN2nScjp/0UXZKhLJPL96sZX+6h8T
 RBl/qVh2wWu6L/Khqv0SymB4xGqVS6XBfFovaiQLjnG0Er1DV5UWIkz9bYMr7HrzXb5+118tO
 3BaU7dhO6lWK9z32ITR3+2FtKtyj/9mXaEcji70iLUSwZS9GdqKo1tqC6ZH2FIUglNG/WBk/J
 nntkETopdY5JRqMFIFcJHzOgvE3aGah4XC/MmjUS3NwsP+wr2yWpvaw3SRq+R16W/dtpAKJ9v
 LVAZP1qzBpYLEWzaKNCvULC3g2jGCQfd9m1vwl+2n6SJ7g5y71LIs/cHfXzIGrUfmVrvA/SVG
 7DrxgXZSYxlY8ZMXFkKuQ8LC0lJPLqgIbE9cK6i89QS5DZyRe17h0say85WjpfDRktPlFguBN
 I1fvhqG+zzEhVGpSx5Imfdtb/wMygpKLxGUtg+IGmMbssVPmGc4I4b8Xr53Cl16vWMqv6uoKZ
 7YR21ovAzIPrfGAQuI4XZjFdJcKr1n8eyq3/w3KSQPBqMaI2Pxx8m6YzEkt/UvtPMH27YM3vr
 wH69ByZD4vVR35HJBSFrvXvp8nvs9wqeTr0UotyA/eJslYx5fNyVr9D1Y5gn1r9f/60j6FvAy
 ThPfoIabNje8VKNEQO9DNNF9BM37bAFbsTVEIZ3Ow1I5EJZPPjkjbMbA53FRxjzMpymE2WbpY
 iqUmb/a0=
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On the primary side we don't actually need the replication
block driver, since it only passes trough all IO.
So simplify the setup and also use 'blockdev-add' instead of
'human-monitor-command'.

This is how my clients use colo in production.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 docs/system/qemu-colo.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/docs/system/qemu-colo.rst b/docs/system/qemu-colo.rst
index 75abbd80298df79223cb8e70064a5dc83d70f4eb..f7d3b6439cf3401a58c4126342=
39d1a43999a10e 100644
=2D-- a/docs/system/qemu-colo.rst
+++ b/docs/system/qemu-colo.rst
@@ -240,8 +240,8 @@ Note:
 **4.** On Primary VM's QEMU monitor, issue command::
=20
     {"execute":"qmp_capabilities"}
-    {"execute": "human-monitor-command", "arguments": {"command-line": "d=
rive_add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,fi=
le.host=3D127.0.0.2,file.port=3D9999,file.export=3Dparent0,node-name=3Drep=
lication0"}}
-    {"execute": "x-blockdev-change", "arguments":{"parent": "colo-disk0",=
 "node": "replication0" } }
+    {"execute": "blockdev-add", "arguments": {"driver": "nbd", "node-name=
": "nbd0", "server": {"type": "inet", "host": "127.0.0.2", "port": "9999"}=
, "export": "parent0", "detect-zeroes": "on"} }
+    {"execute": "x-blockdev-change", "arguments":{"parent": "colo-disk0",=
 "node": "nbd0" } }
     {"execute": "migrate-set-capabilities", "arguments": {"capabilities":=
 [ {"capability": "x-colo", "state": true } ] } }
     {"execute": "migrate", "arguments": {"uri": "tcp:127.0.0.2:9998" } }
=20
@@ -269,7 +269,7 @@ Primary Failover
 The Secondary died, resume on the Primary::
=20
     {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0"=
, "child": "children.1"} }
-    {"execute": "human-monitor-command", "arguments":{ "command-line": "d=
rive_del replication0" } }
+    {"execute": "blockdev-del", "arguments": {"node-name": "nbd0"} }
     {"execute": "object-del", "arguments":{ "id": "comp0" } }
     {"execute": "object-del", "arguments":{ "id": "iothread1" } }
     {"execute": "object-del", "arguments":{ "id": "m0" } }
@@ -309,8 +309,8 @@ Wait until disk is synced, then::
     {"execute": "stop"}
     {"execute": "block-job-cancel", "arguments":{ "device": "resync"} }
=20
-    {"execute": "human-monitor-command", "arguments":{ "command-line": "d=
rive_add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,fi=
le.host=3D127.0.0.2,file.port=3D9999,file.export=3Dparent0,node-name=3Drep=
lication0"}}
-    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0"=
, "node": "replication0" } }
+    {"execute": "blockdev-add", "arguments": {"driver": "nbd", "node-name=
": "nbd0", "server": {"type": "inet", "host": "127.0.0.2", "port": "9999"}=
, "export": "parent0", "detect-zeroes": "on"} }
+    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0"=
, "node": "nbd0" } }
=20
     {"execute": "object-add", "arguments":{ "qom-type": "filter-mirror", =
"id": "m0", "netdev": "hn0", "queue": "tx", "outdev": "mirror0" } }
     {"execute": "object-add", "arguments":{ "qom-type": "filter-redirecto=
r", "id": "redire0", "netdev": "hn0", "queue": "rx", "indev": "compare_out=
" } }
@@ -341,8 +341,8 @@ Wait until disk is synced, then::
     {"execute": "stop"}
     {"execute": "block-job-cancel", "arguments":{ "device": "resync" } }
=20
-    {"execute": "human-monitor-command", "arguments":{ "command-line": "d=
rive_add -n buddy driver=3Dreplication,mode=3Dprimary,file.driver=3Dnbd,fi=
le.host=3D127.0.0.1,file.port=3D9999,file.export=3Dparent0,node-name=3Drep=
lication0"}}
-    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0"=
, "node": "replication0" } }
+    {"execute": "blockdev-add", "arguments": {"driver": "nbd", "node-name=
": "nbd0", "server": {"type": "inet", "host": "127.0.0.1", "port": "9999"}=
, "export": "parent0", "detect-zeroes": "on"} }
+    {"execute": "x-blockdev-change", "arguments":{ "parent": "colo-disk0"=
, "node": "nbd0" } }
=20
     {"execute": "object-add", "arguments":{ "qom-type": "filter-mirror", =
"id": "m0", "insert": "before", "position": "id=3Drew0", "netdev": "hn0", =
"queue": "tx", "outdev": "mirror0" } }
     {"execute": "object-add", "arguments":{ "qom-type": "filter-redirecto=
r", "id": "redire0", "insert": "before", "position": "id=3Drew0", "netdev"=
: "hn0", "queue": "rx", "indev": "compare_out" } }

=2D-=20
2.39.5


