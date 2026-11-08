Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAE4606A320
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=M4QSiqdf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQ2LX-0005gE-Ii; Sun, 08 Nov 2026 07:50:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xQ2LR-0005ev-QE
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 07:50:03 -0500
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xQ2LP-0005zT-OS
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 07:50:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1794142168; x=1794746968; i=deller@gmx.de;
 bh=nf4VC6oHoYIK2l/a8FrJUb8qCoJRyi01CxmGK/VZorQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=M4QSiqdf2JvFn8+dhfoYw6xK8Uy9tcVKz2moH9gNPDDD7a13VfhJtLrZYKiagvUe
 3LFs6iWW2jIvXVRQM8bUYuWawL6pFRZgT2/IWsRxNTAVU3UPTdOSnqiMs0jyGpfy5
 On1sYsEUua5uCTMsE3KmM1iX7LJ/KnaJFX4KTyj3H9cUzCc/ymttoiqjpp+Q4kHOI
 3KZz7mIuFF3dJt5cKpMxkTTn10bdwK+hsRfJLf9Ov4lRzZbY92jSMTbkMhMJAgqES
 1SZIoRUUOSO8uKfIIRnV1YnojVSFDHyeRgOqpLrbRP0QUgENF4HDIK3Jm5mvvRXaz
 r+uLnt+b0ZVxNyc1uA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Hdw-1xSm9q2chO-00Epel; Sun, 08
 Nov 2026 13:49:28 +0100
Message-ID: <e3ad4417-8310-42c7-824d-31d60c7221a9@gmx.de>
Date: Sun, 8 Nov 2026 13:49:26 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ncr53c710_v2: add new NCR53C710 chipset driver
To: BALATON Zoltan <balaton@eik.bme.hu>, Helge Deller <deller@kernel.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Keith Monahan <keith@techtravels.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261106221818.139086-1-deller@kernel.org>
 <20261106221818.139086-3-deller@kernel.org>
 <94ff409d-d896-c4fb-0550-0ffc77cd1006@eik.bme.hu>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <94ff409d-d896-c4fb-0550-0ffc77cd1006@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hFXFmrz1hzZc1Gmai5N8yKhB/xd3MztSLWBWeQD15hGnevr4u/7
 zmP3wJBwO6qMLSCOJsK8wm+cBkKBteBDBc2X1BciQo/qDXL11GxYe4mZ+gNzCWuC6zZoh4d
 TbfxqQILh/WUbEeqoz+JHjCuhxnHBv5jDA19MuFazrGr+G8uZsPcYzcpHzIMZnlRuwB+BWI
 Caw61XXHlEky5nXl+qKDg==
UI-OutboundReport: notjunk:1;M01:P0:5cXvAoWjFlQ=;SjVoeZwJlvMWkfSG8v0FslWreuX
 3NqGgQpHk719c6chfHTJpXEIsjHV2U3koiaUYxdXbqJNsHhaTlmO2h6d3ZgSPWbTVp2hHIzRn
 0Zryg5Lz7hDS0mLFwCipCmAGiINTLyQV7bXa/PL6pMiw/vWci50yRsfDHTcDan8Axt3cOaEbo
 5GkxzmNrlZFzIjy0lWDqnfxodvevTWLHHaf/6SCoNJcVunt9V5Wgg7MFaOOPDM43jeX9UrwAt
 /F5i6XDQODBAS4jHm45wirgu5yxZq0rMQiRxcBHsZNm+1T1gqeq7ANPekY9EvBrgDHutP98cU
 sjbiXlGAq25ONzXxnn2QYpshymlxQyUkv4I7CVcJXBvNCOb1PgZDMq+zL8jdPdC+j3kTH9tsl
 0gesVO2CpPJgUqvDfHC0j8AdVcYAZ9ALcTuQBiFesIWQBp5QMfml/trFXTCPvZDlsHT5+VaTG
 w9BRX5EnkO6+ByCIp75OdANBMpicHrFjl0kK+LQawmKMvr5SXKfzE0WdJYGp3vSNZpLun9Nbc
 I7D5nCDbvMVFpyT+F1XfgSsC4kofyJPyKNTSwAN7fv7Og4RLoqBIalh9kkeZOyb0AEW3+jBSL
 Ws0JL9w9b4l9NHNlA/Ci75wT7G7isV19YmuWiM5UiQ+Z08AUYNUxnSE0n7Gg9TjOG7f81YQJH
 QCmEUmAoCxYePmvgF/XMK7C1GVTojRxHk02OdiFP433nnHRvanYl+1ZqCgBeLc9/sacSh/oJx
 KgeDnTWeYQGcnyie9tOO0Z7yiSZFydsftC78m9LLQ5oCxcknOKo7HFM3jHzjv/7vEdC+kUY3N
 xlHpAOGzVIbjIrtX/2htaTjjwKMMIDYU3IRHLdoviUkQhWW353Zh0vgmYwQRldmwePBU64qfi
 b7h1TKAiwrGDTfMuD9a8FTFFzJphwp5G28A9LD2jwG2YserKzAJbbTzL7Khij3prbT8Oo6FGd
 QrJdxB/Ab9jwZL9MxGoZ+QOBm7neqmNDFvfnNf80C3qrdRKbSuNd5RaK4ck4zoV5E+gkHKDnn
 ukAotKD5K0t3lLFwBphdOhyCRd2AoG1eAKdRNHHl1uuC+KJyk1kJmjtD78l1GfktJLH69i5/K
 mF3ddLiQP6dQrNDLBpIeBNeQMGOWl1mLbT5L1jDnZIcZNqA34o3DndJBso4wLutQBZb3oYRgg
 91ofPby5k2H5pXZpoWYmJCbOPJ3rH4qVvr/qb9vf8fTDb40hxV8d4WUYTT23md/kS4H5JtFhC
 l4JK4XjdQPT4vD/Dq/dhCUbPbQXvMzEU3m9ZCUUhcn/tk+M/ASn+I8zaVFYsOE63yeMrxCVZO
 40CjA97cprwiGlRXYP5ur+QDvik8UD+PoIvYiCXCHck7kndDKcrCF0VIvULo66p2ElVRKgjQJ
 bqeifDqJdcWNoTSDLn5FNwpRKTxOnJy7sdDbeIsR0dWiEsPerNxZ+w2U51ScSLPZe+lCTXD8W
 Iypxdu2BcTYOWWOEGTvfV2bDz0DC0X62ZXgJEHZ3jpH0uO8PYiVFlvtTzLbuntQywyhIQt0QU
 iRQZ+p4B4jALHnYSY1HwN/s7POSdhKrLwSRT5hJ2EiE75bc/+zn8gMDaFmaBlEJzznRL5QTKY
 tICYLpyMefSR4UXZFYQxKBBnko0ScFfJISmR1yI448xVm4cMFIcOkic69M564OPHwUwEP12ai
 j88dFtxJd+vab9Wsspbe1pXLiXOY/eJxmi/wWhqr1r1xFM0z5f1eWVNVdBvg6II1CSHXrBIOf
 bKyqE3E1K2+JrwfkVgW4G36RFbtuvtfHpj/7o0LM+HopQw61ernrtla2FxjRra8GeutGeA8m6
 q3zmGgIktXDZaB2FPkZccl5jpneXz3+hvXuKphFtqg63tn3z7fmYVA6KwxfG2/lGshdh/6XV3
 U1bs349jUytvpduhEkI/+Q6Z7ELaciCmyQIBH9236uRjBzt8m7AVXwGN4oOlDK1yXP24O4ae8
 rwBztjLQe+hjOYElPZqQ6g51EvpxcEJv01yfB1rjunD3RnNQCosdMZg7czbZuaDDXCSTUOxDs
 5LKXF5CSlH2pP+kNrTQAX+NMeRpRGX86sz6CzMJaL8wSiam+lq/+wd1zVmTduxIWEQHln6YHI
 Zvb/8gZ6AMd2T5pCJKdApORtpsuK1/5j/CBrBGMriF0Gz6O36bylJH2e0JJ+c9Y2ka2tmr7hx
 eoR2YzW8fmIHgrsqVvbgSpknim3XAklCeQuovs7/cx9oBXOaiveN3uF5eROUfTq/xvQo8N4Z1
 9XED9hJnrj1Rp5d7U81MzTDVp5M8I2MBkCXtjWYP0WsgMuaWaOosEp5f/vvmsevZ2+3y1xL/v
 IPqriAXTb8b4hgBP0GPjERgnFp0noC95Pl+02lQj1WOCYAUYeeQDUUh6kHUE0vu6g5bF7I/tt
 Qd1UxYFS6jXkOZ9sBweSX9EENq+ZU3R9eHeN8kooeUID3wpfBimzL0W3yKZrCg5UZjkMIPWwU
 8scqukABkJGHfdLEuiBAlx/TzuuAJUGcP7j7KFZGN8hyx2HxLRDJ+EEKi80FLChq9yLQ8D2nl
 BSwx74wveSG2l2ljGq//nDd2qO2zzbKNJD9gVXJEXt5/f7gQd/edDszSGksFrRRroQgo8Fsuc
 lMtH9Xu1hwJePuATm8+Ja8rMgtCreabga/VQk7aMBUZNI1PIep6mBc4G7JR6z3RphrajQylu4
 d4asJJyUTDFDQxmOM40b090tyYZ4bWmyt9UbOvAGT1xRoKidpdNORj7oFpa5/yRHEFRTkQUI/
 rzhFR4EHoo7W4moh8JV2hgGY37nRAyHoFsfGlf+Z9fCZrw50nPobD4bj34EAGrq61pvQi3JWM
 o5ZQCqK5o317NjwqMPhJO1Wz2kPR2ZRnyAoq47r/V3z9mVyI8Y6N+aBiY1ur83vFmFbiK/xIV
 qJDB4yyVw1lzbXMMuoOMj0ip8J8wnf522L4mBwzFJXpA1l1AJwRrV1jMVxBXkuV+WjLz0Nc+r
 vQ+xKTzoV9eCbt7hl4Rxs1n6S2q8EZ4uddKC0hUjnoEHtxfJ9wroNnhBzC8ajXMgUFE4uDsNG
 BTn6uR1wxnHizXusj5hxnCqH+PwG3awqAF7gseF0fvhT1A8/YcZ9bg4FdKTiyqpggM+a6oIrZ
 pjaK9nxSx+Q7HXPHpZ3TCmtgbTWBgt3ufCC7vYaEGVuLuQC3pZomOsUj+MmdkapPqhDWjsSAo
 GLUO7DwquxEXtRTmoIhSqrFpPm2jrrsVG+c9NQljh2NsXrx1J3si8sDc0ZDrMzA6w6GImrx7P
 x3uU6iuaa871DMAVqoF8Z4DpNH2emp0idBYZLs82pYkyM5GSyWPnPKTdOwOEcXsyBQAZoB670
 Yiht9KjiEHAWFVstg1hTaBVMR+p4LZulynEd6eKcCUd2B73Uj2wSEzSVRdhjk78niT501POMG
 bLb0Dn6g+aievALSXqyZQ95+e12FJQcOFc/StuAAd66E5THTM6+TuYcLk36jEI0WY4DadAdem
 eI1jN7iDGmZCoUSK1HYXPg3gEz2SSju7nwVjOTNIaZaTXmf4lDuYuXifUa3s392NzgcFEZQl+
 bk5lmKBXnmw97nC3kQLuZvjUvV9v9GPSBn0ZNIpQYJltYuJZwh4ixaRFdotDlQSozK/eG5AU0
 v0AP+bHLtHRQkK3+Tj1xyzENpOK/eNXAIG88MtoifwAmGFbJKk7WNr4oW7jGS9NTdxH/qQ32l
 GVbvRNjJlNfN4/rN8fbdlpR8JOlt7yEDeRzshSSUAhYgybNeurS7EuPN7P75Gg77OPLLIvQ+S
 Om3OO9emN8DWpkZymSSrQucY5sbRQPn5c/S3r4txNW7f4KRfRnqYkQgWLPCrvHKeZ2A5QgpZT
 rwAFkjHvk0jEq5H1WLiymkZTrkhzDc6oqnHP+gxM9kXvpPn9gjy5gT3uaZliNwofIuJ74912U
 Ng+FwtiDNVUGNbDt1R44tXzt8ULPS8lmnztybiVW65E3IlbAuywrMK0DCCGJA1kqB874vX9wm
 d4gZAbExRa7vmbGu0AJu1cVSP64WNrgRika94sBkYDbn6eY3GzIospro1IoYIlz0g8JIH8+2V
 3Me0PsFoU5YIpRgBSWF/sZTb9CNLH02bGLBcN3sx3ytlgGJExkD9vtJ8Pb8fqz/fAA6jMwlqd
 IW37cBwOnsHJ85gmmUpYzfaSTTUTmrkEp8yte3xtC7VRddhrZ9+j/IIChfWbb8rckt+UQmyyz
 SiKDKoz7QBZtFS9kOgbDi5SUlT6nvaaLJHcqAmMOCm4qm9DKw3x5TErJFTSd4VEPB2T0DWoFK
 leg14XRv74lOd+oA1oE9CE2RKpjdg3XP90KIq0ZEJoyGkJbfeQg8fpDmvRuRnwc0eX3KEBl8E
 XIBAU7G/dIqR6d5XhbumRGaRucpkHztDEhuKbOMhGehZnJbyvp7yEcB5tXHMoW8cdtJQcbhGi
 8ZFp25cFxXMF0CCdtpEKCZE58J/dsi5O1Djc9Ccn8tFxsMuiOAe75rBW/mDamkoL7x/a+AuLP
 os+4P5EhhvUMwP0JLIVbvoFauBknoW9U1eXnCsK4hK/+CUbFJ4G7PsYN15OCFbaEeneVPWubl
 bJkEc6qX61I0nO0NKU8HbdunmBBBOG/nq3LUj4oIirRICZ1/7qyFPnahr/9mXN9aCSGruCMM3
 juSCPPk7ZargXtNwR+ms9YxdIfPyTiBpcE2o/MuKbp6cHoLFeCefBLz1D90jB0GWZWgcp6x0T
 YtztWpiO5+iKWpheifre+UAFjJClVywmgnRAACaoWi/m9ZUlqa0bvrjoMGPC3Bd7/lTlT42gR
 3lfAWDPcSLtReckYJHnkybSrc6Z4lQIIFuzTNkIBzHmWx0RvrYFheBOVO5wb6nFHMjRrrOPkz
 YwIwedLMXY32doy42Jx3csKfQfzLu5gJvyC62sew45dxVhlVbICDiL+6WnNJzrfuPZvD74KBq
 GqOoiTHPf0whjzL3YN0nlLa6H8TTFSFeCE2KMArU4oxHN5kvFIIRLzUMd1yCJEPUk20DdfSNY
 DsQW9xk1CtiMdGRfnCRVNLHh2fjjOaiO2paAZjeAOgk7zyelUoVdJxHTtIwNif+D+0zXkL8yZ
 /1T3w4wmUCSuqX0sgneAPFt426RBI5xCrUswNsqHIxfEb/F0DmulLW6J123CPKWQSNhcMK1jN
 fqR3Sl2TmvY4ZPomBA12DZSdFIBmcVnVgYdZoV+fXWgHRSqeNMCEMvF72QKWfe58eUtNlYtOY
 QS+k7E++v2zQPkPSVKHMC/T/O/VTPqDnr6L2fufKS0Vl28ZUEWum7OHOgv+l7DnVQgua3c9dY
 txc25AdnHZCic5G7SZUdrNFZS3wNl2At9Ld1GmyAxoFlyENka+pZQBEseLuP6mO1eV26knPNv
 7lFMHywzS/qLT8rFTskWqVpOGrl20wnBbO0zNNQfTeUTw784xr4dDeUg07ofJg4PqO7TRvqvY
 bep/MO/7q30n+kEoYXAWBGPwRUtBhvMWCGLdIoDlRWJaqND1PNFTp5ukrATUM7xVcguzQTxkB
 vRK59yJG5eftrzofdhYkilO4QgAY06zYXkDSMjwPdlA710wIqdN4fhgoi2DoWbaOyZJaZ697c
 M9841vG2fUFayKPMQr4ANsOmjf2IyeP4umiByBUJfDGqIDs7+blPgkbXcxrZJlh6hU5KDe+zP
 HKVe3JT1dg8gxamDnicmyKYnTZ0xw9gxKVcP1qvI/z1CTWloVAnh25tQZmfOCl3YihaWXfejf
 ytE8bQ+gnRo1Q+I6K8HnzSHaNSmpp7dkH6PtZsTxy2NJmQspyKrJYS/Wy+gx01qM8k6vB84F1
 3qBpbRTR5624pmb3r6Ul6JLrGXh6j16MjgchuBxqlnlYMNXCxym9Y0ZuE1dFpJLSEfEW/34Th
 DlG90rPly3b0UO3G6TVjC96x7sVKzNk8AjO5eRFIYKJqnD6wl6y7TBIFp+NbU2N4apx88WKFM
 zn9dC/jFzVjyMP1UlQVAbRDEmMQ7747iP/oMqPfR4eC8iDGEgXrRNde5ulortRchGvo0VcFjj
 xkNzX75XCFCE6NxXAjpBtQ9nQuxxHVvWE1TMD3jRUCI4WkCKRemiNhoOt+7lXKG+NqXuEQ9aE
 UJpwxmb4yuf2JY5FR10dl4UAiKA5YrCuOgUfVqX1yNL1mFN6LzsnPRaIjMaUpl+GXkZQPKmSQ
 AvGZdU2sgO5JXJYYQkoWzKdwwVqiVitduTkO8YRhFO50dAh6pLqp+jiCH852yNKXe2zB2jA/4
 y47RqbvN2sj6h1qQCs79M30nc/pSH/ExzDVFE+i78EPcjYlSrMwqkvv3CYZmVrhlR4uEo+JAN
 JAMTKBkfnpmB25jDZL1hYLY9j13+RqxBKQmJgWPDgaIv6/9QhpqTXKpsLdqycSL99pOpMIrVR
 Xw3jBgsDU5xZKCa8RyLCInt7jxZ1iia6HEVWr0r6JB4W/6JLJZHhCuvfVCbnh9mm7cNJ6zuvV
 nJtfQ03BDZ2Udoz6G+fwUuKmgUd3NtNYY+I9DeWogmlvPOHGKk9BIWhsa4fziA8hgmlAzK/LW
 H1kgxQxb+6kUfLg83ONiqw7fNyNMLQbVho1Z/DdrfbadpdW2hMR8yyi+nnNaNdD/Y5Ds/lKe9
 WrH+l6MpFkhBj4RO5y8vlTBa904kvJg9MqJZ20iPZI7XmWPRMrAe9tIAmpypkHyaK3iSWyqMd
 sWrANqFXBgPCECEhNvhRQhN4KmVKSObGjPge8BSgMnFSYmISDECC7D9LcSxC/Zg5uHF1ItGv9
 pelUwGyYzKUq+4HfQQrItpRvZ3OJqQA9P9zB0aJ372WlYjLqiExfexqn0PzZYLtBpUfxO56xv
 VQPAGRbHOzQyPVHzfY45WBRwLz4eP+8f6oHvqbuMUSX988rWj+JslZJeyFUvxuWOsv7Ck6Luu
 8nux3smDcgu7OSPb91GzgjppGJ4SJR1isFitgYa8z2kevzs6PQrV0EcQnt5JhkPmgNdMBmsf+
 yxTk72ue9fsFjBAzI3YM2ieQbv+H5QPUskaJLeBEmhMf01w/HVzjRbGibge22A7tem84HPt/n
 9vyU50pVcbYp02z6b1FlhkmaWDZ1EWjCXFSGY+se71fm56NHmyXET7k32R2fDLxVetuGyi83b
 P2mJm3lOc8RjqjVOVq0ujXNVVAj6Szf3PbbkMrCKP0Iz3P1Vy+sltVoPdmK4pRiICqYFK9wZY
 DUiqotmoScdcz5vvvInvTlqGGNiHSpU8siXYHnCYT6qbmYVhQgXMW+y3ch9YQ246qO7h8NbT8
 gFsN2Z46jGZrEtsjZi/kJu1uMYYACUuT4a8aPrVFVUtatyISdps6okB612unX5m3Hd7dIGcx0
 f6WgbhkP+GWmsx0wALte58lSySVcwSwvib1BvMJHaRTmpPg0gNPs3rZlbRawjF/Htcr4PW4Zx
 p200mKr/oP+Jq0Itm5q4bpeHb20RX2qeZPcSD9sQSRoT4pFGdvWlAcs6SEVTqW9NiMmYsDa0x
 5usMQGqDWima8RyZSkSOFJ0kzGJkgh5pwnsgwGM/XlL/S/94OJYCWic6VC3vd4Tt5qA/1IvjR
 7sS82raoNlrBsVNtu5XoTguaumpCsefNySCs2SNw=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Balaton,

On 11/8/26 12:43, BALATON Zoltan wrote:
> On Fri, 6 Nov 2026, Helge Deller wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> This adds a new driver for the NC53C710 chipset. This drover is based o=
n the
>> lsi53c895a driver, and thus avoids many issues of the existing ncr53c71=
0
>> driver, which was written from scratch.
>=20
> There's a typo "drover" above.

Thanks! I'll fix it the next round.
 =20
> I asked this before but would it be possible to modify lsi53c895a.c
> to also emulate the 53c710 too instead of duplicating code?

Maybe. At least in theory: Probably.

> This device model is almost the same as the 53c895a or at least a
> large part is shared but it's not easy to see that as it uses
> different names for the same structures and functions. It would be
> better to at least split the reused struct definitions from 53c895a
> into a shared header and use that here. Then compare what are the
> differences between the functions and see if the common parts could
> either be split into a common super class or if the differences are
> small enough to just add conditionals in lsi53c895a.c to also emulate=20
> 53c710 with most of the code shared instead of duplicated.
Well, this is a lot of work.
And I'm not sure if you gain that much from that exercise.
If you are a person which really want to know all differences between
those two SCSI chips then this is most likely a very interesting project.
But I fail to see someone who volunteers for this, who has the time and
interest to really do this and who still guarantees he will not break the =
lsi53c895a.

Looking at the Linux kernel, there are lots of different drivers driving
all various variants of those SCSI chips. The 710 was one of the earlier
SCSI chips (e.g. ISA bus, no PCI,...) while the 53c895a is a newer chip
for PCI.
> A somewhat complex example of such code sharing is hw/isa/vt82c686.c
> which uses a common super class or hw/display/ati.c which has
> conditionals to emulate simlar devices. I was thinking about such
> code sharing would be possible for these devices too to avoid code
> duplication that can diverge in the future.

Yes, generally I prefer code sharing too.
But in this case the 710 is currently only used by the parisc emulation
(and might be used by one or two old historic non-x86 arches maybe too).

Helge

