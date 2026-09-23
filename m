Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A64CC9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 19:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Svp-0006OE-GT; Wed, 23 Sep 2026 15:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x9Svl-0006NZ-Ak
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:47:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1x9Svj-0000Ck-9G
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790192816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7i5HtfloYxFtV5+h8Z3iawp0mtuiIizv87Z4mhjZS2Q=;
 b=h13dJjgI71yf/g0EC2hiaPBV2+gdEL9fENcNIvw+4cGihlnEcnFwqMNtFFNIvJTx/Rwv8a
 88umI8WlZq0BfQ0zukgKB62fwkX04B/MukBAiY9JHx4WlVM4vTJIpgQ/DLhvFMe3ON3Awf
 hTGCRb9J9UiVAXa0bjvAf3ISKxMqhP8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-Y2PF73G8MbKA7aVTG11VmQ-1; Wed,
 23 Sep 2026 15:46:55 -0400
X-MC-Unique: Y2PF73G8MbKA7aVTG11VmQ-1
X-Mimecast-MFC-AGG-ID: Y2PF73G8MbKA7aVTG11VmQ_1790192814
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14327180AD72; Wed, 23 Sep 2026 19:46:54 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3CDD31953948; Wed, 23 Sep 2026 19:46:53 +0000 (UTC)
Date: Wed, 23 Sep 2026 15:46:52 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com
Subject: Re: [PATCH 00/88] qemu-iotests: migrate away from HMP ("make HMP
 optional" follow-up)
Message-ID: <20260923194652.GA2936157@fedora>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
 <arOecUpHWrEI5xI6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eTulOXU0qvKTQ2bI"
Content-Disposition: inline
In-Reply-To: <arOecUpHWrEI5xI6@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--eTulOXU0qvKTQ2bI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 11:40:01AM +0200, Kevin Wolf wrote:
> Am 22.09.2026 um 22:17 hat Marc-Andr=C3=A9 Lureau geschrieben:
> > Hi,
> >=20
> > This series migrates all qemu-iotests away from HMP, so that the test
> > framework no longer depends on it and can execute with --disable-hmp.
> > This can simplify the tests, as they don't need to check/grep on stdout,
> > HMP & QMP but can rely increasingly on QMP alone.
> >=20
> > The series is organized as follows: preparatory patches, monitor
> > infrastructure, test infrastructure, test migrations, cleanup.
> >=20
> > x-query-qtree (info qtree) is introduced to make test 172 migration
> > easier, but arguably, qom-list could be extended instead.
> >=20
> > All migrated tests have been verified to pass.
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Argh, noticed only now that the Cc: list is a bit short. Everyone seeing
> only this email, please check the series and my reply on qemu-devel (and
> add the necessary CCs when replying).

Here are the original authors of test cases. I will take a look at the
ones that I wrote but I can help with the leftovers too:

001	Christoph Hellwig
002	Christoph Hellwig
003	Christoph Hellwig
004	Christoph Hellwig
005	Christoph Hellwig
007	Christoph Hellwig
008	Christoph Hellwig
009	Christoph Hellwig
010	Christoph Hellwig
011	Christoph Hellwig
012	Christoph Hellwig
013	Christoph Hellwig
014	Christoph Hellwig
015	Kevin Wolf
017	Kevin Wolf
018	Kevin Wolf
019	Kevin Wolf
020	Kevin Wolf
021	Christoph Hellwig
022	Kevin Wolf
023	Kevin Wolf
024	Kevin Wolf
025	Stefan Hajnoczi
026	Kevin Wolf
027	Stefan Hajnoczi
028	Stefan Hajnoczi
029	Kevin Wolf
030	Stefan Hajnoczi
031	Kevin Wolf
032	Kevin Wolf
033	Paolo Bonzini
034	Kevin Wolf
035	Kevin Wolf
036	Stefan Hajnoczi
037	Kevin Wolf
038	Kevin Wolf
039	Stefan Hajnoczi
040	Jeff Cody
041	Paolo Bonzini
042	Kevin Wolf
043	Stefan Hajnoczi
044	Kevin Wolf
045	Corey Bryant
046	Kevin Wolf
047	Kevin Wolf
048	Miroslav Rezanina
049	Kevin Wolf
050	Paolo Bonzini
051	Kevin Wolf
052	Stefan Hajnoczi
053	Stefan Hajnoczi
054	Kevin Wolf
055	Stefan Hajnoczi
056	Ian Main
057	Wenchao Xia
058	Wenchao Xia
059	Fam Zheng
060	Max Reitz
061	Max Reitz
062	Max Reitz
063	Alexandre Derumier
064	Jeff Cody
065	Max Reitz
066	Max Reitz
068	Max Reitz
069	Max Reitz
070	Jeff Cody
071	Max Reitz
072	Max Reitz
073	Kevin Wolf
074	Fam Zheng
075	Stefan Hajnoczi
076	Kevin Wolf
077	Kevin Wolf
078	Kevin Wolf
079	Hu Tao
080	Kevin Wolf
081	Beno=C3=AEt Canet
082	Kevin Wolf
083	Stefan Hajnoczi
084	Jeff Cody
085	Jeff Cody
086	Kevin Wolf
087	Kevin Wolf
088	Kevin Wolf
089	Max Reitz
090	Max Reitz
091	Jeff Cody
092	Kevin Wolf
093	Fam Zheng
094	Max Reitz
095	Jeff Cody
096	Alberto Garcia
097	Max Reitz
098	Max Reitz
099	Max Reitz
101	Stefan Hajnoczi
102	Max Reitz
103	Max Reitz
104	Hu Tao
105	Fam Zheng
106	Max Reitz
107	Max Reitz
108	Max Reitz
109	Kevin Wolf
110	Max Reitz
111	Max Reitz
112	Max Reitz
113	Max Reitz
114	Kevin Wolf
115	Max Reitz
116	Stefan Hajnoczi
117	Max Reitz
118	Max Reitz
119	Max Reitz
120	Max Reitz
121	Max Reitz
122	Kevin Wolf
123	Max Reitz
124	John Snow
125	Max Reitz
126	Max Reitz
127	Max Reitz
128	Stefan Hajnoczi
129	Fam Zheng
130	Kevin Wolf
131	Denis V. Lunev
132	Fam Zheng
133	Kevin Wolf
134	Daniel P. Berrange
135	Jeff Cody
136	Alberto Garcia
137	Kevin Wolf
138	Max Reitz
139	Alberto Garcia
140	Max Reitz
141	Max Reitz
142	Kevin Wolf
143	Max Reitz
144	Jeff Cody
145	Kevin Wolf
146	Jeff Cody
147	Max Reitz
148	Alberto Garcia
149	Daniel P. Berrange
150	Max Reitz
151	Max Reitz
152	Fam Zheng
153	Fam Zheng
154	Kevin Wolf
155	Max Reitz
156	Max Reitz
157	Kevin Wolf
158	Daniel P. Berrange
159	Reda Sallahi
160	Reda Sallahi
161	Alberto Garcia
162	Max Reitz
163	Pavel Butsykin
165	Vladimir Sementsov-Ogievskiy
170	Reda Sallahi
171	Tom=C3=A1=C5=A1 Golembiovsk=C3=BD
172	Kevin Wolf
173	Jeff Cody
174	Nir Soffer
175	Nir Soffer
176	Daniel P. Berrange
177	Eric Blake
178	Stefan Hajnoczi
179	Eric Blake
181	Kevin Wolf
182	Fam Zheng
184	Manos Pitsidianakis
185	Kevin Wolf
186	Kevin Wolf
187	Kevin Wolf
188	Daniel P. Berrange
189	Daniel P. Berrange
190	Eric Blake
191	Kevin Wolf
192	Fam Zheng
194	Stefan Hajnoczi
195	Kevin Wolf
196	Vladimir Sementsov-Ogievskiy
197	Eric Blake
198	Daniel P. Berrange
200	Jeff Cody
201	Daniel Henrique Barboza
202	Stefan Hajnoczi
203	Stefan Hajnoczi
204	Eric Blake
205	Vladimir Sementsov-Ogievskiy
206	Kevin Wolf
207	Kevin Wolf
208	Stefan Hajnoczi
209	Vladimir Sementsov-Ogievskiy
210	Kevin Wolf
211	Kevin Wolf
212	Kevin Wolf
213	Kevin Wolf
214	Max Reitz
215	Max Reitz
216	Max Reitz
217	Max Reitz
218	Max Reitz
219	Kevin Wolf
220	Eric Blake
221	Eric Blake
223	Eric Blake
224	Max Reitz
225	Max Reitz
226	John Snow
227	Kevin Wolf
228	Max Reitz
229	Jeff Cody
231	Jeff Cody
232	Kevin Wolf
233	Daniel P. Berrang=C3=A9
234	Kevin Wolf
235	Vladimir Sementsov-Ogievskiy
236	John Snow
237	Kevin Wolf
238	Stefan Hajnoczi
239	yuchenlin
240	Alberto Garcia
241	Eric Blake
242	Andrey Shinkevich
243	Kevin Wolf
244	Kevin Wolf
245	Alberto Garcia
246	John Snow
247	Kevin Wolf
248	Vladimir Sementsov-Ogievskiy
249	Alberto Garcia
250	Vladimir Sementsov-Ogievskiy
251	Max Reitz
252	Max Reitz
253	Max Reitz
254	Vladimir Sementsov-Ogievskiy
255	Kevin Wolf
256	John Snow
257	John Snow
258	Max Reitz
259	Max Reitz
260	Vladimir Sementsov-Ogievskiy
261	Max Reitz
262	Kevin Wolf
263	Maxim Levitsky
264	Vladimir Sementsov-Ogievskiy
265	Max Reitz
266	Max Reitz
267	Kevin Wolf
268	Alberto Garcia
270	Max Reitz
271	Alberto Garcia
272	Max Reitz
273	Kevin Wolf
274	Kevin Wolf
277	Andrey Shinkevich
279	Stefan Hajnoczi
280	Kevin Wolf
281	Sergio Lopez
282	Daniel Henrique Barboza
283	Vladimir Sementsov-Ogievskiy
284	Daniel P. Berrang=C3=A9
286	Max Reitz
287	Denis Plotnikov
288	Stefan Hajnoczi
289	Max Reitz
290	Alberto Garcia
292	Alberto Garcia
293	Maxim Levitsky
294	Maxim Levitsky
295	Maxim Levitsky
296	Maxim Levitsky
297	Kevin Wolf
298	Vladimir Sementsov-Ogievskiy
299	Vladimir Sementsov-Ogievskiy
300	Max Reitz
301	Eric Blake
302	Nir Soffer
303	Andrey Shinkevich
304	Stefan Reiter
305	Alberto Garcia
307	Kevin Wolf
308	Max Reitz
310	Andrey Shinkevich
312	Alberto Garcia
313	Alberto Garcia
314	Andrey Drobyshev

Stefan

--eTulOXU0qvKTQ2bI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmq0LKwACgkQnKSrs4Gr
c8iPEgf+OT1/QynUfQzmiXlBAhCA6p7ohld+2FJ8ABYNhEAFM0kI+JB/8JahI1Yj
CR4FyNugMVGw60UTQJzO/6Eph06dqSoYEGe1eGgJAzuuBWWWDbf7IfbhFDDWS+gQ
kXP5uQd8gA8u06Y9Lo+vIsPK+pKxX9J71yGbDRPgQYLm7QCMpH14+2oM2ulH0jPw
ICdjDMf+fVo+tCkMjdTqNz8okm928kpVDbTjwJ0MsA68/yROqZ62Qd2ehCht5XXI
5V7JwcMHOl2aEt8ZkNjkv5AD59Rr/7J6XXax15wr4miu69Kw4gRX52WyKgflybVw
cSQRdf3+LdPEV06P8s6vR0sqG8sW5w==
=yXsq
-----END PGP SIGNATURE-----

--eTulOXU0qvKTQ2bI--


