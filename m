Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876BBC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7k3-0005QL-Gb; Wed, 12 Aug 2026 08:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu7jp-0005OK-6K
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:07:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu7jm-0006Ce-9e
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:07:16 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB46Bw3265804
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gTt7pE2AcakU2ZsQ5j5CGm+ZF2h9iyAckd3WIwC8Qlg=; b=TMV4vHUS5nSl5Ken
 9tF4ZsoIMPKHB0OwGjQE4XCQ0I8RzrBawtkghXl9rkYKYegQs3AU6jz0sn2hbX/d
 lO8pCLez2mFMH1OR+kW2gdSjExAfk7eNp6v0/La3mYW3fjnXmsqPIzUdqgy6Hg04
 IFAZBsWQAiGKt+Ru0C0tkGptE29hDRZMVYRV7Q5lfCNn6RbzRYvQiNvqtxINLE+q
 JqAurXWoiB4qK/tgOcqnHnTd5aLHu4AJbi2a551GhRr3YYSU6IDbtLNg3v8/6enP
 M2Mw8mwfw4YQt4p1EVR/pgbpjL5tWX7n6al1Ju9hjnnk7+iy29TFMwdXJ9LIxQdr
 Bfi0SQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08jrkqba-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:07:11 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso7351181cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786536431; x=1787141231; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gTt7pE2AcakU2ZsQ5j5CGm+ZF2h9iyAckd3WIwC8Qlg=;
 b=Fm5UbCC+dcw6hnMMb7qodc3trCE0UQ9+FvoeU4xq/Tu07KL6aZGyZLzTyi5ocTiGPC
 GuS0df1c7pUf6nU1EppteohEXa4kwkKFLGMCgPr19HqjUw+WtJ6089WFmftGPJ1gG7UN
 74IoAh2HGcIt80+Tp7q2PhB9v2UdhcMNbsHg7Zo+l7r5GuXPx9o3o7yS6xTQCYCgb7n/
 +Q8mVyuYSNmRgH8Mo7R4Wkdzblp15tmefSMdmmmre0+GLjVZgXve9It5NUAO9MUDTnUI
 avAXSysrtcAot8vcZ0dD6MlKi1Nt0St/qku+dSXcJZv8H1CJmO4+ebdzImoEYbcxIeSs
 1kdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786536431; x=1787141231;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gTt7pE2AcakU2ZsQ5j5CGm+ZF2h9iyAckd3WIwC8Qlg=;
 b=HA97HD0ocpSWGcYG6KOvxr3jidmypvnCeo2xzGsLbTOdwiP/3HicyJqv2v9rQ2nvZ3
 Jg3kdi38KrZVrHPJP2nVa1nnQKfD9kIaI3hn8JfHWkCp8rfh/PUzVesMnjjlIiwlS8iK
 uw8ShRN6C/zRpmTXnwNoLtQQUCkciwQOKLWAw6Cz7wPu+Gz4OharE0Te38FYNpobol8R
 8pRXABWugyvnXeCXC14J87LRTO78001H630g9l4O8jgskzbzv+zc7/rsM0v0FS4KyX8a
 PLKznGRhb/E07g+V+zCPy32GLeXv/gR/pIl33D+Hd9CbX1EGt3EoXhCVgz/ya8l18hyb
 eW3w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq6D+8sNAnGNFSfeXvV2SFpVJwF2tYn+hpEXytc7cfu1J0vxtX3BnbOgATI4P3xTVET6vKjoAAqrczV@nongnu.org
X-Gm-Message-State: AOJu0YzJhfVY1AwX9I7futHPE2Btv9RMOHzTeHRcpsZbCw/iqKTWxw0e
 Mc7eCkPiYt7WCRoW1sfgFhpO+ryB73O/tk2t0gSZ+cP4aoo/3USo83Dhwc01dutiou0JIbsgN1w
 A949DU183Lx2bebrQc3nPXok7hWwpiYxsYeh8Xn5eYDBjcvHALk7DD/kn4Q==
X-Gm-Gg: AR+sD1157ckNPyeQHIkEE++f+jgT+dSkILEE0RG8z01KWFdMr+aHi177f4pXHM+4udF
 lg4YdlBpSH5ZBvCGz3agx/cMywiju2Kf9yg8kaZaD0EMMDkFUjchefqVehqA5iLGzRx08MJ2F4C
 SwddWxHgsnvIxnKdLcAanSqgxWTTZjTHtECfHzxG3koWEobHP3deG0CO1rtJ5WtcCRNDBLpNEMV
 nQhw6jTX+wxVTEVpjOCjWolMdAiEc5cA/XjX0uzyF/VA7cSXQilwvbw497fAu2gBZ3D9Z2QzL8f
 WiVk4PDiJOuLRVP/1wBbF+ZhDgkB9F7MumCA2cMqKZLIKIMs4xHeIROmr03rZEGNM4eLTOsUR4d
 Uo5EYOkwrzt2Brb0xiV8lyjgj3TDl9gF9a18=
X-Received: by 2002:ac8:7c4e:0:b0:528:15e:d1d4 with SMTP id
 d75a77b69052e-52d646c6abbmr33333841cf.4.1786536430577; 
 Wed, 12 Aug 2026 05:07:10 -0700 (PDT)
X-Received: by 2002:ac8:7c4e:0:b0:528:15e:d1d4 with SMTP id
 d75a77b69052e-52d646c6abbmr33333231cf.4.1786536430114; 
 Wed, 12 Aug 2026 05:07:10 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150bf5f0esm6641211f8f.4.2026.08.12.05.07.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 05:07:09 -0700 (PDT)
Message-ID: <b7e9bb43-66ba-48e2-9020-319f702e075f@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 14:07:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailmap: map the last From-munged author back to a real
 identity
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260812112456.970371-1-den@openvz.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260812112456.970371-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JXI4xGk6ncRiv1Waxc5OIBN0BWFUn5Fg
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5OCBTYWx0ZWRfX87tOvdCjY76m
 ESJEYHoPBM4iBNa93UtmMks49/Hke6IEFOINGBhjQOrmJUnk9jaepISTyGcL2sbP47MkhwSG8vN
 GIcQ282ByQ78NDsAbPVU33y8T00pEXs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5OCBTYWx0ZWRfX4jKhjYaI6jvg
 EdnsJe0wCZUFxQ3i0NlVw/H7svm9vMFGef2pK9BDakBr5EalsjMKkrLoIiSsaebI01ZSpMgvGXq
 ziejc9lg9tIA6SiQvdwwOGIDNpQd0Ob+XiB3nwHt23YZNgNLYXFqTQl4OZu/Bq9BBZaevjh9bDN
 5rD2Scb/2DkqciNwODl4EUFD0TiREN5emVZ+moqZaqne/4WwGxY/EJvIlDii+cTMATuBKEe/c6l
 pwQWVtQ0EHM1vQscUptOZ0xL+lmtw87KzLqyxmBv5BYtUw889S2MZgqhfwlLCLMKhLA32jdK+FO
 u7/EjvNNsoLt8/gb9G+Jc3A9JK7TgTEcD+pxyrqk2UQG9gh8PzJO96jW/N+wmb4EiJBdlJnNXVC
 kemLTjhyHWqqm5/ylNOAkHipZYddvtQZlPdJLYf1YDdyyxIJwHh2SrdEQf3PsSyzAXb8EYEFRnN
 putx9LeslzMX3zm4URw==
X-Authority-Analysis: v=2.4 cv=Z7Dc2nRA c=1 sm=1 tr=0 ts=6a7c61ef cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=rrnns3bz6RDiLcQG:21 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=69wJf7TsAAAA:8 a=6rqHouBjAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=9qUTvQc-AAAA:8 a=cplnpDx6AAAA:8
 a=cZssYg63UNXFfzrU7x4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=Hx1yvPaMooE3kwe23bt7:22
 a=cvBusfyB2V15izCimMoJ:22 a=axOgMmt4Ejcwn1cqzmsR:22 a=bHwCOBSOUrNypjIvOSWD:22
X-Proofpoint-ORIG-GUID: JXI4xGk6ncRiv1Waxc5OIBN0BWFUn5Fg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120098
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 12/8/26 13:24, Denis V. Lunev wrote:
> qemu-block@nongnu.org rewrote the From: header of commit b67e353863
> ("block: drop force_dup parameter of raw_reconfigure_getfd()") for
> DMARC reasons, so it landed in git attributed to the list instead of
> to its author, whose real address is in the Signed-off-by trailer.
> Map it like the other munged identities collected in that section.
> This was the last one left unmapped, so 'git log --format="%aN"' no
> longer reports any author 'via' a list.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> CC: Alex Bennée <alex.bennee@linaro.org>
> CC: Eric Blake <eblake@redhat.com>
> CC: Michael Tokarev <mjt@tls.msk.ru>
> CC: Laurent Vivier <laurent@vivier.eu>
> ---
>   .mailmap | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

