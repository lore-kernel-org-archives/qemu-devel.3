Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA5CCA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 19:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulYL9-0007K0-A1; Mon, 11 Aug 2025 15:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ulYKu-0007GY-A8
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 15:37:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ulYKk-0003xb-Tm
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 15:37:35 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BGESoe010041
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 19:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=MyOgHjBYYMKt9HMvenjZWbkT
 C9+ScgzNIWdSuMydwfY=; b=Rgf213w76ynB3um7vMlJnfcfej/d9xJY3K+JuMzP
 TCN1GI/GAuwSbtPX7dfAJ/DjLCOI9EbrnDcuNJZ6yW7Zm4WX9iQPA3XHWQDFPe1w
 zb7f5o62lLe4czdxAe2bYcNxY3P70pHq48G2PSG7+goOtsWmlixNUi4YcW5l+uLx
 acj/xlp568N7VYfJ6RdwrFYfT0Q7pzZG7rg1jVVRIl2QozrEWjNzcV1uh7ohdOS1
 2QuEzFgzp1BkGEfXgFEEvKUWLE254/zA5C2QXzB6ed27vyktUQ8/qi+xh0EID+W7
 nRq0C5si6Fq0odWKZUFsOTHdSAsitrLOe1sbPEqtSYSgdA==
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhx3ug6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 19:37:25 +0000 (GMT)
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e8e1b5e7e26so6318275276.3
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 12:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754941044; x=1755545844;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MyOgHjBYYMKt9HMvenjZWbkTC9+ScgzNIWdSuMydwfY=;
 b=Xhn91/uNq16qRH3cjLtokro1NxnsaZCXn+FHp/Q6RNW/QHJe+jb2+5VVInf2zizzhc
 jEZIECKs3dZ4srVbCx/KIPnMmbxe5LBBgUtlzRDsbaWzfMgVB5eAySLJVihQcvBkbkm0
 9vt/NiIlpuFakxuAfLrP8eLw1vmgHxLJnsQ4ooHfmQiBfBDeBo4rjqf/pCcYu8uMSnjH
 NSvd8xrMkPGZbjjawOOkNBcUe3Z8tbalV09wtP4f2tfnuZA1eCq+00FBj+N+Y+RGXptH
 AZ+jTUFnWQ3/NazqnEAP4GX3aY7mTvyMXDcpPIXx3FvQa/PnxGBC8a4nS26tIoTb7xVx
 AzRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjVK3H++s7472Ynt78JVd/HqeH37rtMVpsQwllu3gFfJNA9P5r2XGAeFTttBO8lotnGA6wp6QNgTId@nongnu.org
X-Gm-Message-State: AOJu0YwPTw4UNV0XErAI/H+zECGK0l0PTffT6a+EQl5PhTyAywapun+Y
 6PC8q93ATX+vx0cuR5swo9cbA1bLUDwrrSNqnMUSVbAABVTGn7ToQ2Fu5ldk3znJQUuC3zTM99u
 fqWrkeNh75LDr5BiMxk6ZIugZwRSSrlSdIBhxM8B17rWGHV+nVF33vnV4twvjQebm705r/1liHO
 HkH0aXpla+jrJ41ZkJODxdFpmLtcSGuFu0OH1z1UUAgqcAlQ==
X-Gm-Gg: ASbGncte0fZX7mKTsnZlIjpix8g1PHiGtiuEhL3wern0YTP0qLx7RTvXUfr+F+p/nLh
 pmVoyKD7JBrZPquDshWz/klxpkR0oQ+xuqKb9WEbKhWa7hJcaYr+RFQjnKhlcs58BPmCcP0zNM6
 TDUo6EsqWJEyOPATRR1J4j59s=
X-Received: by 2002:a05:6902:e04:b0:e90:69a1:1799 with SMTP id
 3f1490d57ef6-e917a263991mr1340150276.32.1754941044478; 
 Mon, 11 Aug 2025 12:37:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTNToA+ZCADla3FaB1yevm9lcgeRsr5CFijkpJHKu1ww3BP+GfaGbWTUgD3TEnPQh7G3OiQd5UP5/osfVLwIA=
X-Received: by 2002:a05:6902:e04:b0:e90:69a1:1799 with SMTP id
 3f1490d57ef6-e917a263991mr1340118276.32.1754941044044; Mon, 11 Aug 2025
 12:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250722201404.2368507-1-vacha.bhavsar@oss.qualcomm.com>
 <20250722201404.2368507-2-vacha.bhavsar@oss.qualcomm.com>
 <875xf36qyk.fsf@draig.linaro.org>
 <CAFEAcA8o4wEHHDXVj0Fcc3i8g+49psY7YSf1AqGiGe9vNuXiQA@mail.gmail.com>
 <87ikj3545v.fsf@draig.linaro.org>
 <CAFEAcA-Y7utLb9cciGJOVAPF8Y0W4RxcOLDnNS7ptpHtYVG_EQ@mail.gmail.com>
 <CAEWVDmsOD-vNc6YbwfND9yzfz-G8kEsFfpEtJ5A+duhUzGU2Pg@mail.gmail.com>
 <CAEWVDms3R+_dv79GTdmzbJBJ3rb=hSi7rRj=f4rzRFwsHnzXJg@mail.gmail.com>
 <CAFEAcA_Q-MhmFNvXUwUXF2_MJqHxujPL7C3=PxC8=hMprerDxA@mail.gmail.com>
In-Reply-To: <CAFEAcA_Q-MhmFNvXUwUXF2_MJqHxujPL7C3=PxC8=hMprerDxA@mail.gmail.com>
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 15:37:13 -0400
X-Gm-Features: Ac12FXzkirCQSzrqBa8EGJFIE1R_sCI49lZB169IkkBVUMG83req9LEARYgGmNs
Message-ID: <CAEWVDmv3ZCs8tW0pzH0sX_SUOdj-fyFwVz0uSRowziga=hCF1Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] target/arm: Increase MAX_PACKET_LENGTH for SME ZA
 remote gdb debugging
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000884853063c1c0dc0"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfX2IEqyNYuuzbK
 gXThsWyb1WkQPC1nIpS6iUWnAzPXNEwE6eOs3ODBKdudIy0hhVFEy3esstPal9zKjA/YUB6i39l
 SBZXIbdICFnXBme48qDWMUf13LmQzcBITMv+/XVXWnYfyGgb46Ys9KWuyf65YB0bN1kXyc7rRG7
 yaQOAkNLy6G17Q9NDCNkb9jhT1V7aI0QBw54ghOtYBDoz8dm/MYdtka1mm+llqgZLrXv2a+ec9Q
 yk5+lxf+03SBzvZDWJNCj/hzzlywfnoedvkFYVw4SbMd7DZhlcLaFwLYxkUEIIiM5wAZIDw5sYa
 ifwJkHUTKWMc0dAyQXDTP9x/sDIpKlsnJqS2j1mbczSyOPWjed/0cuz19GTUREB3og/1kRkl2af
 9dUsA+P6
X-Proofpoint-GUID: x-ojEPhpQhYWtWwdYb70ssfSW8wMxgHj
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689a4675 cx=c_pps
 a=OxDXTYJfYfhXdKRNwaci0A==:117 a=2OwXVqhp2XgA:10 a=tk1fAI5CypgQKhaZt9gA:9
 a=QEXdDO2ut3YA:10 a=VWM_7Ik0QpPsEaYKe28A:9 a=cxVRdw0VslE0MYWkNwNp:22
X-Proofpoint-ORIG-GUID: x-ojEPhpQhYWtWwdYb70ssfSW8wMxgHj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--000000000000884853063c1c0dc0
Content-Type: text/plain; charset="UTF-8"

Hi,

From testing with a max vector length, the minimum size the buffer needs to
be is 131077 to survive the worst case of a P packet with the ZA register.
This is enough to fit the whole ZA register plus the overhead for the P
packet (command + register number, the checksum is not stored in line_buf)
and the null terminator. I had overshot and rounded it safely to 131100,
and it seems gdbserver has done the same thing but they specifically
counted 32 bytes for overhead, it's not specified why. So the 131100 is
large enough, however I have changed it to 131104 just to stay consistent
with gdbserver and have added this note to the comment you've suggested to
be placed above MAX_PACKET_LENGTH. I've also changed line_buf to be a
GString as Alex suggested.

I have sent a new version with these changes. Looking forward to your
feedback!

Thanks,
Vacha

--000000000000884853063c1c0dc0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>From testing with a max vector length, the mini=
mum size the buffer needs to be is 131077 to survive the worst case of a P =
packet with the ZA register. This is enough to fit the whole ZA register pl=
us the overhead for the P packet (command + register number, the checksum i=
s not stored in line_buf) and the null terminator. I had overshot and round=
ed it safely to 131100, and it seems gdbserver has done the same thing but =
they specifically counted 32 bytes for overhead, it&#39;s not specified why=
. So the 131100 is large enough, however I have changed it to 131104 just t=
o stay consistent with gdbserver and have added this note to the comment yo=
u&#39;ve suggested to be placed above MAX_PACKET_LENGTH. I&#39;ve also chan=
ged line_buf to be a GString as Alex suggested.<div><br></div><div>I have s=
ent a new version with these changes. Looking forward to your feedback!</di=
v><div><br></div><div>Thanks,</div><div>Vacha</div></div>

--000000000000884853063c1c0dc0--

